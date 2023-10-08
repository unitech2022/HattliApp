import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';



part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  changeLang(lang, context) async {
    AppModel.lang = lang;
    await saveData(ApiConstants.langKey, lang);
    // EasyLocalization.of(context)?.setLocale(Locale(lang, ''));

    //  pushPageRoutName(context,  GlobalPath.chooseLoginRegister);
    emit(AppState(changLang: lang));
  }

  getLang() {
    if (AppModel.lang == "") {
      emit(AppState(changLang: "ar"));
    } else {
      emit(AppState(changLang: AppModel.lang));
    }
  }

  getPage(context) {
    getLocation();
    Future.delayed(const Duration(seconds: 3), () {
      firebaseCloudMessagingListeners();

      if (AppModel.lang == "") {
        Navigator.pushReplacementNamed(context, lang);
      } else {
        if (isLogin()) {
          if (currentUser.role != "") {
            if (currentUser.role == AppModel.userRole) {
              pushPageRoutName(context, navUser);
            } else {
              pushPageRoutName(context, navProvider);
            }
          } else {
            pushPageRoutName(context, selectAccount);
          }
        } else {
          pushPageRoutName(context, selectAccount);
        }
      }
      // FlutterNativeSplash.remove();
      emit(AppState(page: "done"));
    });
  }



}
