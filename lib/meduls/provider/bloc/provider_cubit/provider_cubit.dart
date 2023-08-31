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
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/common/models/response_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/utils.dart';
import '../../../common/models/address_model.dart';
import '../../../common/models/category.dart';
import '../../../common/models/product.dart';
import '../../models/details_provider_response.dart';

part 'provider_state.dart';

class ProviderCubit extends Cubit<ProviderState> {
  ProviderCubit() : super(const ProviderState());

  static ProviderCubit get(context) => BlocProvider.of<ProviderCubit>(context);

  changeCurrentCategory(CategoryModel newValue) {
    emit(state.copyWith(categoryModel: newValue));
  }

  changeArea(double newValue) {
    print(newValue);
    emit(state.copyWith(area: newValue));
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
      'IBan': provider.iBan,
      'NameBunk': provider.nameBunk,
      "email": provider.email,
      'LogoCompany': provider.logoCompany,
      'ImagePassport': provider.imagePassport,
      'NameAdministratorCompany': provider.nameAdministratorCompany,
      'AddressName': provider.addressName,
      'Lat': provider.lat.toString(),
      'Lng': provider.lng.toString(),
      'Area': provider.area.toString()
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
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم انشاء الحساب وهو في حالة المراجعة".tr(),
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
      'area': provider.area.toString(),
      'LogoCompany': provider.logoCompany,
      'ImagePassport': provider.imagePassport,
      'NameAdministratorCompany': provider.nameAdministratorCompany,
      'IBan': provider.iBan,
      'NameBunk': provider.nameBunk,
      'id': provider.id.toString()
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} =======> updateProvider");
    }
    if (response.statusCode == 200) {
      pop(context);
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم تعديل البيانات بنجاح".tr(),
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
    products = [];
    emit(state.copyWith(getDetailsProviderState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/provider/get-provider-details?providerId=$providerId&UserId=${currentUser.id}'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("${response.statusCode}=======> getProviderDetails");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      DetailsProviderResponse detailsProviderResponse =
          DetailsProviderResponse.fromJson(jsonData);

      if (isEdit == true) {
        getProviderForUpdate(detailsProviderResponse.provider);
      }
      emit(state.copyWith(
          getDetailsProviderState: RequestState.loaded,
          detailsProviderResponse: detailsProviderResponse,
          area: detailsProviderResponse.provider!.area));
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
        categoryModel: categories.firstWhere(
            (element) => element.id == provider.categoryId,
            orElse: () => categories[0])));
  }

  int currentPage = 1;
  int totalPages = 0;
  List<Product> products = [];
  List<Product> newProducts = [];

  Future getProductsByProviderId(
      {page, context, providerId, isState = true}) async {
    newProducts = [];
    if (page == 1) {
      products = [];
      newProducts = [];
      currentPage = 1;
      totalPages=0;
    }

    if (isState)
      emit(state.copyWith(getProvidersByProviderIdState: RequestState.loading));

    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/product/get-Products-By-providerId-page?page=${page.toString()}&providerId=${providerId.toString()}'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("getProductsByProviderId========> ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      newProducts = [];
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      ProductsResponsePagination productsResponsePagination =
          ProductsResponsePagination.fromJson(jsonData);
      newProducts = productsResponsePagination.items;

      totalPages = productsResponsePagination.totalPages;
      products.addAll(newProducts);
      if (isState) {
        emit(state.copyWith(
            getProvidersByProviderIdState: RequestState.loaded,
            productsResponse: productsResponsePagination));
      }
    } else {
      if (isState)
        emit(state.copyWith(getProvidersByProviderIdState: RequestState.error));
    }
  }
}
