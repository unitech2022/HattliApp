import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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
  Future userLogin({userName, context,role}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(
      loginUserState: RequestState.loading,
    ));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.loginPath));
    request.fields.addAll(
        {'DeviceToken': 'ffffffff', 'UserName': userName, "code": "0000", 'Role': role});



    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> loginUser");
    }

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      UserResponse userResponseModel = UserResponse.fromJson(jsonData);

      token = "Bearer ${userResponseModel.token}";

      currentUser = userResponseModel;
      currentUser!.token = "Bearer ${userResponseModel.token}";

      await saveToken(userResponseModel);
      pop(context);
      // pushPageRoutName(context, ClientPath.home);
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
      showErrorLoading(context, 'something_went_wrong'.tr());
      emit(state.copyWith(
        loginUserState: RequestState.error,
      ));
    }
  }

// check userName
  Future checkUserName({context, userName}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(registerUserState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.checkUserPath));
    request.fields.addAll({'userName': userName});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      CheckUserResponse checkUserResponse =
          CheckUserResponse.fromJson(jsonData);
      if (checkUserResponse.status == 1) {
        pop(context);
        // pushPage(
        //     context,
        //     VerificationScreen(
        //         phoneNumber: userName,
        //         verificationCode: checkUserResponse.code));
        emit(state.copyWith(
          loginUserState: RequestState.loaded,
        ));

      } else {
        pop(context);
        showTopMessage(
            context: context,
            customBar: const CustomSnackBar.error(
                backgroundColor: Color.fromARGB(255, 211, 161, 11),
                message: "الرقم غير مسجل ",
                textStyle: TextStyle(
                    fontFamily: "font", fontSize: 16, color: Colors.white)));
                      emit(state.copyWith(
          loginUserState: RequestState.loaded,
        ));
      }
    } else {
      pop(context);
      showErrorLoading(context, 'something_went_wrong'.tr());
      emit(state.copyWith(registerUserState: RequestState.error));
    }
  }
}
