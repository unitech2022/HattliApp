import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/animations/slide_transtion.dart';
import 'package:hatlli/meduls/common/ui/otp_screen/otp_screen.dart';
import 'package:hatlli/meduls/provider/ui/navigation_provider_screen/navigation_provider_screen.dart';
import 'package:hatlli/meduls/user/ui/navigation_user_screen/navigation_user_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/utils.dart';
import '../../models/check_user_response.dart';
import '../../models/response_register.dart';
import '../../models/user_response.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  selectRoleAccount(int type) {
    currentUser.role = type == 0 ? AppModel.userRole : AppModel.providerRole;
    emit(state.copyWith(roleUser: type));
  }

// ** startTimer
  int start = 60;
  Timer? timer;
  void startTimer() {
    start = 60;
    emit(state.copyWith(timerCount: 60));
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          emit(state.copyWith(timerCount: 0));
        } else {
          start--;
          emit(state.copyWith(timerCount: start));
        }
      },
    );
  }

// ** register
  registerUser({context, userName, fullName, email, role, city}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(registerUserState: RequestState.loading));

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.signUpPath));
    request.fields.addAll({
      'userName': userName,
      'FullName': fullName,
      'Email': email,
      'Password': 'Abc123',
      'Role': role,
      'City': city
    });

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("${response.statusCode} ======> loginUser");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      ResponseRegister responseRegister = ResponseRegister.fromJson(jsonData);

      if (responseRegister.status) {
        // await  userLogin(context: context, userName: phone);
        print("success");
        Navigator.of(context).pop();
        // pushPage(
        //     context,
        //     VerificationScreen(
        //         phoneNumber: userName,
        //         verificationCode: responseRegister.message));
        emit(state.copyWith(registerUserState: RequestState.loaded));
      } else {
        // ResponseRegister responseRegister = ResponseRegister.fromJson(jsonData);
        Navigator.of(context).pop();
        // showTopMessage(
        //     context: context,
        //     customBar: CustomSnackBar.error(
        //         backgroundColor: Colors.red,
        //         message: responseRegister.message,
        //         textStyle: const TextStyle(fontSize: 16, color: Colors.white)));
        emit(state.copyWith(registerUserState: RequestState.loaded));
      }
    } else {
      Navigator.of(context).pop();
      showErrorLoading(context, 'something_went_wrong'.tr());
      emit(state.copyWith(registerUserState: RequestState.error));
    }
  }

// ** resendCode
  Future resendCode({userName, code, context}) async {
    if (timer!.isActive) {
      timer!.cancel();
    }
    showUpdatesLoading(context);

    emit(state.copyWith(resendCodeState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.baseUrl + '/send-sms'));
    request.fields.addAll({'userName': userName, 'code': code});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> resendCode");
    }
    if (response.statusCode == 200) {
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
              backgroundColor: Colors.green,
              message: "تم ارسال الكود مرة أخرى",
              textStyle: const TextStyle(fontSize: 16, color: Colors.white)));
      startTimer();
      emit(state.copyWith(resendCodeState: RequestState.loaded));
    } else {
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
              backgroundColor: Colors.red,
              message: "حدث خطأ يرجي اعادة المحاولة",
              textStyle: const TextStyle(fontSize: 16, color: Colors.white)));

      emit(state.copyWith(resendCodeState: RequestState.error));
    }
  }

  ///** */ login method
  Future userLogin({userName, context, role, code}) async {
    bool internetResult = await hasInternet();
    showUpdatesLoading(context);
    emit(state.copyWith(
      loginUserState: RequestState.loading,
    ));
    if (internetResult) {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.loginPath));
      request.fields.addAll({
        'DeviceToken': 'ffffffff',
        'UserName': userName,
        "code": code.toString(),
        'Role': role
      });

      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print("${response.statusCode} ======> loginUser");
      }

      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        UserResponse userResponseModel = UserResponse.fromJson(jsonData);

        token = "Bearer ${userResponseModel.token}";

        currentUser.id = userResponseModel.user!.id;
        currentUser.role = role;
        currentUser.deviceToken = userResponseModel.user!.deviceToken;
        currentUser.token = token;
        currentUser.status = userResponseModel.user!.status;
        currentUser.userName = userResponseModel.user!.userName;

        // print("token" + token + currentUser!.userName);
        await saveToken(currentUser);
        if (timer!.isActive) {
          timer!.cancel();
        }
        pop(context);
        if (role == AppModel.providerRole) {
          // pushPageRoutName(context, navProvider);

          pushReplaceTranslationPage(
              context: context,
              transtion: SizeTransitionPage(
                page: NavigationProviderScreen(),
              ));
        } else {
          pushReplaceTranslationPage(
              context: context,
              transtion: SizeTransitionPage(
                page: NavigationUserScreen(),
              ));
          // pushPageRoutName(context, navUser);
        }

        emit(state.copyWith(
            loginUserState: RequestState.loaded,
            userResponseModel: userResponseModel));
      } else {
        pop(context);
        showErrorLoading(context, "something_went_wrong");
        emit(state.copyWith(
          loginUserState: RequestState.error,
        ));
      }
    } else {
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "لا يوجد اتصال بالانترنت".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      emit(state.copyWith(registerUserState: RequestState.noInternet));
    }
  }

//** */ check userName
  Future checkUserName({context, userName, role}) async {
    bool internetResult = await hasInternet();
    showUpdatesLoading(context);
    emit(state.copyWith(registerUserState: RequestState.loading));
    if (internetResult) {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.checkUserPath));
      request.fields.addAll({'userName': userName, "userRole": role});

      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print("${response.statusCode} ========> checkUser");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        CheckUserResponse checkUserResponse =
            CheckUserResponse.fromJson(jsonData);
        pop(context);

       if(checkUserResponse.status==2){

         showTopMessage(
             context: context,
             customBar: CustomSnackBar.error(
                 backgroundColor: Colors.red,
                 message: "تم غلق هذا الحساب".tr(),
                 textStyle: TextStyle(
                     fontFamily: "font", fontSize: 16, color: Colors.white)));
       }else{
         pushTranslationPage(
             context: context,
             transtion: SlideTransitionPage(
                 page: OtpScreen(
                   phoneNumber: userName,
                   codeSend: checkUserResponse.code,
                 ),
                 dx: 1.0,
                 yx: 0.0));
       }
        // pushPage(
        //     context,
        //     OtpScreen(
        //       phoneNumber: userName,
        //       codeSend: checkUserResponse.code,
        //     ));
        emit(state.copyWith(
          loginUserState: RequestState.loaded,
        ));
      } else {
        pop(context);
        showErrorLoading(context, 'حدث خطأ');
        emit(state.copyWith(registerUserState: RequestState.error));
      }
    } else {
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "لا يوجد اتصال بالانترنت".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      emit(state.copyWith(registerUserState: RequestState.noInternet));
    }
  }

//** */ createProvider
  Future createProvider(
      {context,
      title,
      logoImage,
      desc,
      imagePass,
      userId,
      address,
      nameAdmin,
      categoryId}) async {
    showUpdatesLoading(context);

    emit(state.copyWith(createProviderState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/provider/add-provider'));
    request.fields.addAll({
      'title': title,
      'LogoCompany': logoImage,
      'about': desc,
      'ImagePassport': imagePass,
      'UserId': userId,
      'addressName': address,
      'NameAdministratorCompany': nameAdmin,
      'CategoryId': categoryId.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      pop(context);

      emit(state.copyWith(createProviderState: RequestState.loaded));
    } else {
      pop(context);
      emit(state.copyWith(createProviderState: RequestState.error));
    }
  }

// ** uploadImage
  Future uploadImage({type}) async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(state.copyWith(imageState: RequestState.loading));
      String fileName = image.path.split('/').last;
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });
      final response =
          await Dio().post(ApiConstants.uploadImagesPath, data: data);
      if (response.statusCode == 200) {
        if (type == 0) {
          emit(state.copyWith(imageLogo: response.data));
        } else {
          emit(state.copyWith(imagePass: response.data));
        }
      } else {
        emit(state.copyWith(imageState: RequestState.error));
      }
    }
  }

// ** GET PROFILE
  Future getUserProfile({context, userName, role}) async {
    emit(state.copyWith(registerUserState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.checkUserPath));
    request.fields.addAll({'userName': userName});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ========> checkUser");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      CheckUserResponse checkUserResponse =
          CheckUserResponse.fromJson(jsonData);
      pop(context);
      pushPage(
          context,
          OtpScreen(
            phoneNumber: userName,
            codeSend: checkUserResponse.code,
          ));
      emit(state.copyWith(
        loginUserState: RequestState.loaded,
      ));
    } else {
      pop(context);
      showErrorLoading(context, 'حدث خطأ');
      emit(state.copyWith(registerUserState: RequestState.error));
    }
  }

  // ** delete account
  Future deleteAccount({context}) async {
    emit(state.copyWith(deleteAccountState: RequestState.loading));
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiConstants.deleteAccount));
    request.fields.addAll({'userId': currentUser.id!});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ========> deleteAccount");
    }
    if (response.statusCode == 200) {
      signOut(ctx: context);
      emit(state.copyWith(
        deleteAccountState: RequestState.loaded,
      ));
    } else {
      pop(context);
      showErrorLoading(context, 'حدث خطأ');
      emit(state.copyWith(deleteAccountState: RequestState.error));
    }
  }

}
