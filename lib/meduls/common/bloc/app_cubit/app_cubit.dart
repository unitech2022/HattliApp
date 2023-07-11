import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_model.dart';
import 'package:geocoding/geocoding.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  changeLang(lang, context) async {
    // AppModel.lang = lang;
    // await saveData(ApiConstants.langKey, lang);
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
      // FlutterNativeSplash.remove();
      emit(AppState(page: "done"));
    });
  }

  String detailsAddress = "";
  bool loading = false;
  Future getAddresses(double lat, double long) async {
    loading = true;
    emit(state.copyWith(movMapState: RequestState.loading));
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long,
        localeIdentifier: AppModel.lang);

    detailsAddress =
        "${placemarks[0].name},${placemarks[0].country},${placemarks[0].street}";

    // print( detailsAddress+
    // "====== > address");

    loading = false;
    emit(state.copyWith(movMapState: RequestState.loaded));
  }
}
