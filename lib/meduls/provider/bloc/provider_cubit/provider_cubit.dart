import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/utils.dart';
import '../../../common/models/address_model.dart';
import '../../../common/models/category.dart';
import '../../models/details_provider_response.dart';

part 'provider_state.dart';

class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(const ProviderState());
  static ProviderCubit get(context) => BlocProvider.of<ProviderCubit>(context);

  changeCurrentCategory(CategoryModel newValue) {
    emit(state.copyWith(categoryModel: newValue));
  }

  changeCurrentIndexDetailsProvider(int newIndex) {
    emit(state.copyWith(indexDetailsProvider: newIndex));
  }

  selectAddressModel(AddressModel newValue) {
    emit(state.copyWith(addressProvider: newValue));
  }
//** add provider */

  Future addProvider(Provider provider, {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(createProviderState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/provider/add-provider'));
    request.fields.addAll({
      'CategoryId': provider.categoryId.toString(),
      'Title': provider.title,
      'UserId': currentUser.id!,
      'About': provider.about,
      "email":provider.email,
      'LogoCompany': provider.logoCompany,
      'ImagePassport': provider.imagePassport,
      'NameAdministratorCompany': provider.nameAdministratorCompany,
      'AddressName': provider.addressName,
      'Lat': provider.lat.toString(),
      'Lng': provider.lng.toString()
    });

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("${response.statusCode.toString()} ============ > addProvider");
    }
    if (response.statusCode == 200) {
      pop(context);
      pushPageRoutName(context, navProvider);

      // pushPageRoutName(context, navProvider);
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم انشاء الحساب وهو حالة المراجعة",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));

      emit(state.copyWith(createProviderState: RequestState.loaded));
    } else {
      pop(context);
      emit(state.copyWith(createProviderState: RequestState.error));
    }
  }

  Future updateProvider(Provider provider, {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(createProviderState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/provider/update-provider'));
    request.fields.addAll({
      'CategoryId': provider.categoryId.toString(),
      'Title': provider.title,
      'LogoCompany': provider.logoCompany,
      'ImagePassport': provider.imagePassport,
      'NameAdministratorCompany': provider.nameAdministratorCompany,
      'id': provider.id.toString()
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} =======> updateProvider");
    }
    if (response.statusCode == 200) {
      pop(context);
       showTopMessage(
          context: context,
          customBar: const CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم تعديل البيانات بنجاح",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      emit(state.copyWith(updateProviderState: RequestState.loaded));
      getProviderDetails(providerId: provider.id);
      HomeCubit.get(context).getHomeProvider();
    } else {
      pop(context);
      emit(state.copyWith(updateProviderState: RequestState.error));
    }
  }

// ** get provider Details

  Future getProviderDetails({providerId, context, isEdit = false}) async {
    emit(state.copyWith(getDetailsProviderState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/provider/get-provider-details?providerId=$providerId'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("${response.statusCode}=======> getProviderDetails");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      DetailsProviderResponse homeUserResponse =
          DetailsProviderResponse.fromJson(jsonData);

      if (isEdit == true) {
        getProviderForUpdate(homeUserResponse.provider);
      }
      emit(state.copyWith(
          getDetailsProviderState: RequestState.loaded,
          detailsProviderResponse: homeUserResponse));
    } else {
      emit(state.copyWith(getDetailsProviderState: RequestState.error));
    }
  }

// ** get provider by CatId

  Future getProvidersByCtId({catId, context}) async {
    emit(state.copyWith(getProvidersByCatIdState: RequestState.loading));

    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/provider/get-providers-by-catId?categoryId=$catId&userId=${currentUser.id}'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("${response.statusCode}=======> getProvidersByCtId");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getProvidersByCatIdState: RequestState.loaded,
          providers: List<Provider>.from(
              (jsonData as List).map((e) => Provider.fromJson(e)))));
    } else {
      emit(state.copyWith(getProvidersByCatIdState: RequestState.error));
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

      if (type == 0) {
        emit(state.copyWith(imageLogoState: RequestState.loading));
      } else {
        emit(state.copyWith(imagePassportState: RequestState.loading));
      }

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
          emit(state.copyWith(
              imageLogoState: RequestState.loaded, imageLogo: response.data));
        } else {
          emit(state.copyWith(
              imagePassportState: RequestState.loaded,
              imagePassport: response.data));
        }
      } else {
        if (type == 0) {
          emit(state.copyWith(imageLogoState: RequestState.error));
        } else {
          emit(state.copyWith(imagePassportState: RequestState.error));
        }
      }
    }
  }

  void getProviderForUpdate(Provider? provider) {
    emit(state.copyWith(
        imageLogo: provider!.logoCompany,
        imagePassport: provider.imagePassport,
        categoryModel: categories
            .firstWhere((element) => element.id == provider.categoryId)));
  }
}
