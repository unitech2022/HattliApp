import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/meduls/common/ui/otp_screen/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
    emit(state.copyWith(roleUser: type));
  }

// register
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

  /// login method
  Future userLogin({userName, context, role}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(
      loginUserState: RequestState.loading,
    ));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.loginPath));
    request.fields.addAll({
      'DeviceToken': 'ffffffff',
      'UserName': userName,
      "code": "0000",
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
      currentUser.role = userResponseModel.user!.role;
      currentUser.deviceToken = userResponseModel.user!.deviceToken;
      currentUser.token = token;
      currentUser.userName=userResponseModel.user!.userName;
      
      // print("token" + token + currentUser!.userName);
      await saveToken(currentUser);
      pop(context);
      if (role == AppModel.providerRole) {
        pushPageRoutName(context, navProvider);
      } else {
        pushPageRoutName(context, navUser);
      }

      emit(state.copyWith(
          loginUserState: RequestState.loaded,
          userResponseModel: userResponseModel));
    }

    // else if (response.statusCode == 401) {
    //   pop(context);
    //   showTopMessage(
    //       context: context,
    //       customBar: const CustomSnackBar.error(
    //         backgroundColor: Color.fromARGB(255, 211, 161, 11),
    //         message: "الرقم غير مسجل ",
    //         textStyle: TextStyle(
    //             fontFamily: "font", fontSize: 16, color: Colors.white),
    //       ));
    //   emit(state.copyWith(
    //     loginUserState: RequestState.loaded,
    //   ));
    // }

    else {
      pop(context);
      showErrorLoading(context, "something_went_wrong");
      emit(state.copyWith(
        loginUserState: RequestState.error,
      ));
    }
  }

// check userName
  Future checkUserName({context, userName, role}) async {
    showUpdatesLoading(context);
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


// GET PROFILE
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


}
