import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/animations/slide_transtion.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/utils.dart';
import 'package:hatlli/meduls/common/models/category.dart';

import 'package:hatlli/meduls/common/models/order.dart';
import 'package:hatlli/meduls/common/ui/map_screen/map_screen.dart';
import 'package:hatlli/meduls/provider/models/home_provider_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import 'package:http/http.dart' as http;
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/layout/app_sizes.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/widgets/rating_bar_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../provider/bloc/provider_cubit/provider_cubit.dart';
import '../../../user/models/home_user_response.dart';
import '../../../user/ui/details_provider_screen/details_provider_screen.dart';
import '../../models/provider.dart';
import 'dart:ui' as ui;
import '../../models/user_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  changeCurrentIndexNav(int newIndex) {
    emit(state.copyWith(currentNavIndex: newIndex));
  }

  filleterProviders(int id, List<Provider> providers, int categoryId) {
    List<Provider> newProviders = [];
    if (id == 0) {
      newProviders = providers;
      emit(state.copyWith(providers: newProviders));
    } else if (id == 1) {
      newProviders = providers
          .where((element) => element.categoryId == categoryId)
          .toList();
      emit(state.copyWith(providers: newProviders));
    }
    // *** rate
    else if (id == 2) {
      newProviders = providers..sort((a, b) => a.rate.compareTo(b.rate));
      emit(state.copyWith(providers: newProviders.reversed.toList()));
    }
    // *** distance
    else if (id == 3) {
      newProviders = providers
        ..sort((a, b) => a.distance.compareTo(b.distance));
      emit(state.copyWith(providers: newProviders));
    }
  }

  changeCurrentIndexTap(int newIndex) {
    emit(state.copyWith(currentIndexTap: newIndex));
  }

  changeCurrentIndexDrawer(String newIndex) {
    emit(state.copyWith(indexHomeSide: newIndex));
  }
// **  user functions

// ** get home User
  Future getHomeUser({context, isStat = true}) async {
    // print(locData.latitude.toString() + "location");
    String location = "${locData.latitude},${locData.longitude}";
    bool hasInternetResult = await hasInternet();
    if (isStat) emit(state.copyWith(getHomeUserState: RequestState.loading));
    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/home/get-home-data?UserId=${currentUser.id}&location=$location'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getHomeUser");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);

        HomeUserResponse homeUserResponse = HomeUserResponse.fromJson(jsonData);
        categories = homeUserResponse.categories!;

        if (homeUserResponse.address == null && isLogin()) {
          pushPage(
              context,
              MapScreen(
                type: 1,
              ));
        } else {
          addMarker(homeUserResponse.providers!, context,
              lat: homeUserResponse.address != null
                  ? homeUserResponse.address!.lat
                  : locData.latitude,
              lng: homeUserResponse.address != null
                  ? homeUserResponse.address!.lng
                  : locData.longitude);
        }
        if (isLogin()) {
          currentAddress = homeUserResponse.address!;
          updateDeviceToken(
              userId: currentUser.id, token: AppModel.deviceToken);
          currentUser.status = homeUserResponse.user!.status;
          print(currentUser.status.toString() + " abcdefg");
        }

        emit(state.copyWith(
            getHomeUserState: RequestState.loaded,
            userModel: homeUserResponse.user,
            homeUserResponse: homeUserResponse,
            providers: homeUserResponse.providers,
            currentIndexTap: 0,
            orders: homeUserResponse.orders!
                .where((element) => element.order.status == 0)
                .toList()));
      } else {
        emit(state.copyWith(getHomeUserState: RequestState.error));
      }
    } else {
      emit(state.copyWith(getHomeUserState: RequestState.noInternet));
    }
  }

// ** add marker
  Future addMarker(List<Provider> providers, context, {lat, lng}) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/marker.png', 120);

    final Uint8List markerIconMyLocation =
        await getBytesFromAsset('assets/images/mylocation.png', 120);

    List<Marker> list = [];
    for (Provider provider in providers) {
      Marker marker = Marker(
        onTap: () {
          pushTranslationPage(
              context: context,
              transtion: FadTransition(
                  page: DetailsProviderScreen(providerId: provider.id)));
          // onTapMarker(context, provider);
        },
        markerId: MarkerId(provider.id.toString()),
        position: LatLng(provider.lat, provider.lng),
        icon: BitmapDescriptor.fromBytes(markerIcon),
      );
      list.add(marker);
    }

    //  my location s
    Marker marker = Marker(
      onTap: () {
        // pushPage(context, );
        // pushTranslationPage(
        //                         context: context,
        //                         transtion:
        //                            DetailsProviderScreen(providerId: provider.id));

        // onTapMarker(context, provider);
      },
      markerId: MarkerId("my"),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.fromBytes(markerIconMyLocation),
      // icon: BitmapDescriptor.,
      // infoWindow: const InfoWindow(
      //   title: 'title',
      //   snippet: 'address',
      // ),
    );
    list.add(marker);

    emit(state.copyWith(markers: list));
  }

//** onTap Marker */
  void onTapMarker(context, Provider provider) {
    showBottomSheetWidget(
        context,
        Container(
          padding: const EdgeInsets.only(top: 32, left: 18, right: 18),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Texts(
                  title: "تفاصيل المزود",
                  family: AppFonts.moM,
                  size: 14,
                  textColor: Color(0xff4A4A4A),
                  widget: FontWeight.normal),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 75,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xfffafbfb),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Container(
                        height: 41,
                        width: 41,
                        decoration: BoxDecoration(
                            color: Palette.mainColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          'assets/images/marker.png',
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts(
                              title: provider.title,
                              family: AppFonts.moM,
                              size: 14,
                              textColor: Colors.black,
                              widget: FontWeight.normal),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/locationitem.svg"),
                              const SizedBox(
                                width: 5,
                              ),
                              Texts(
                                  title: provider.addressName.split(",")[0],
                                  family: AppFonts.moM,
                                  size: 12,
                                  textColor: Color(0xff4A4A4A),
                                  widget: FontWeight.normal),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RatingBarWidget(rate: provider.rate),
                        Texts(
                            title:
                                "يبعد عنك ${provider.distance.toStringAsFixed(2)} km",
                            family: AppFonts.moM,
                            size: 12,
                            textColor: Color(0xff4A4A4A),
                            widget: FontWeight.normal),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              SizedBox(
                width: 300,
                height: AppSize.s50,
                child: ElevatedButton(
                  onPressed: () {
                    pop(context);
                    pushPage(context,
                        DetailsProviderScreen(providerId: provider.id));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                      Palette.mainColor,
                    ),
                    elevation: MaterialStateProperty.all(10),
                    shape: MaterialStateProperty.resolveWith((states) {
                      if (!states.contains(MaterialState.pressed)) {
                        return const RoundedRectangleBorder(
                          borderRadius: AppRadius.r10,
                          side: BorderSide.none,
                        );
                      }
                      return const RoundedRectangleBorder(
                        borderRadius: AppRadius.r10,
                      );
                    }),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "المزيد من التفاصيل",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.moR,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
            ],
          ),
        ));
  }

  //** format image marker */
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

//** sort providers */
  CategoryModel sortModel = sortRateList[0];
  changeSortModel(CategoryModel newValue) {
    sortModel = newValue;
    emit(state.copyWith(modelSort: newValue));
  }

//**
  flitterListOrders(List<OrderResponse> orders) {
    emit(state.copyWith(orders: orders));
  }
  //** =========================================

  //** provider functions */ ==============================================================

  // ** get home provider
  Future getHomeProvider({context, isState = true, isFirst = false}) async {
    ProviderCubit.get(context).products = [];
    bool hasInternetResult = await hasInternet();
    if (isState)
      emit(state.copyWith(getHomeProviderState: RequestState.loading));
    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/home/get-home-provider?UserId=${currentUser.id}'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getHomeProvider");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);

        HomeResponseProvider homeResponseProvider =
            HomeResponseProvider.fromJson(jsonData);

        currentProvider = homeResponseProvider.provider;
        categories = homeResponseProvider.categories!;
        updateDeviceToken(userId: currentUser.id, token: AppModel.deviceToken);
        emit(state.copyWith(
            getHomeProviderState: RequestState.loaded,
            homeResponseProvider: homeResponseProvider,
            currentIndexTap: 0,
            orders: homeResponseProvider.orders!
                .where((element) => element.order.status == 0)
                .toList()));
      } else {
        emit(state.copyWith(getHomeProviderState: RequestState.error));
      }
    } else {
      emit(state.copyWith(getHomeProviderState: RequestState.noInternet));
    }
  }

  changeCurrentPageSlider(int newIndex) {
    emit(state.copyWith(currentPageSlider: newIndex));
  }

  Future updateUserProfile(int type, {context, name, city, image}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(updateUserState: RequestState.loading));
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.updateUserPath));
    // if (type == 0) {
    request.fields.addAll({
      'fullName': name,
      'UserId': currentUser.id!,
      'city': city,
      'ProfileImage': image
    });
    // } else {
    //   request.fields.addAll({'UserId': currentUser.id!, 'city': value});
    // }

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("updateUserProfile ============> ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      UserModel userModel = UserModel.fromJson(jsonData);
      getHomeUser(context: context);
      pop(context);
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم التعديل بنجاح",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      pushPageRoutName(context, navUser);
      emit(state.copyWith(
          updateUserState: RequestState.loading, userModel: userModel));
    } else {
      pop(context);
      emit(state.copyWith(updateUserState: RequestState.loading));
    }
  }

// ** upload image
  Future uploadImage(int type) async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(state.copyWith(imageProfileUserState: RequestState.loading));

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
        emit(state.copyWith(
            imageProfileUserState: RequestState.loaded,
            imageLogo: response.data));
      } else {
        emit(state.copyWith(imageProfileUserState: RequestState.error));
      }
    }
  }

// Todo : refactor
  updateDeviceToken({userId, token, context}) async {
    // emit(state.copyWith(updateDeviceTokenState: RequestState.loading));
    // var headers = {'Authorization': currentUser.token!};
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.updateDeviceTokenPath));
    request.fields.addAll({'userId': currentUser.id!, 'token': token});
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("updateDeviceToken = : -${response.statusCode}");
    }
    if (response.statusCode == 200) {
      // emit(state.copyWith(updateDeviceTokenState: RequestState.loaded));
    } else {
      // print("updateDeviceToken = : -" + response.reasonPhrase.toString());
      // emit(state.copyWith(updateDeviceTokenState: RequestState.error));
    }
  }
}
