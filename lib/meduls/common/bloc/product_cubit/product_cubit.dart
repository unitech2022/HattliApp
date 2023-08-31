import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/utils.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/meduls/common/models/category.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../../user/models/rate_response.dart';
import '../../models/search_product_response.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  changeCurrentCategory(CategoryModel newValue) {
    emit(state.copyWith(categoryModel: newValue));
  }

  emptyListImages() {
    imagesList = [];
    emit(state.copyWith(images: []));
  }

  isDiscountProduct(bool value) {
    emit(state.copyWith(discount: value));
  }

  selectOptionProduct(String newValue, int type) {
    if (type == 0) {
      emit(state.copyWith(marka: newValue));
    } else if (type == 1) {
      emit(state.copyWith(sizes: newValue));
    } else {
      List<String> images = newValue.split("#");
      emit(state.copyWith(images: images));
    }
  }

  List<ColorModel> selectedColors = [];
  selectColor(int index) {
    colorsList[index].isSelector = !colorsList[index].isSelector;
    // print(colorsList[index].isSelector);
    emit(state.copyWith(optionsState: RequestState.loading));
    if (colorsList[index].isSelector == true) {
      selectedColors.add(ColorModel(
          color: colorsList[index].color,
          name: colorsList[index].name,
          isSelector: true));
    } else if (colorsList[index].isSelector == false) {
      selectedColors
          .removeWhere((element) => element.name == colorsList[index].name);
    }
    emit(state.copyWith(
        colors: getSizes(selectedColors), optionsState: RequestState.loaded));
  }
//** ====== */

  List<SizeModel> selectedSizes = [];
  selectSizes(int index) {
    sizesList[index].isSelector = !sizesList[index].isSelector;
    // print(colorsList[index].isSelector);
    emit(state.copyWith(optionsState: RequestState.loading));
    if (sizesList[index].isSelector == true) {
      selectedSizes
          .add(SizeModel(name: sizesList[index].name, isSelector: true));
    } else if (sizesList[index].isSelector == false) {
      selectedSizes
          .removeWhere((element) => element.name == sizesList[index].name);
    }

    emit(state.copyWith(
        sizes: getSizes(selectedSizes), optionsState: RequestState.loaded));
  }

  String getSizes(List<dynamic> list) {
    List<String> sizesNewList = [];
    for (var element in list) {
      sizesNewList.add(element.name);
    }

    return sizesNewList.join(",");
  }

  List<String> imagesList = [];
  // ** upload image
  Future uploadImage() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(state.copyWith(uploadImageState: RequestState.loading));

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
        imagesList.add(response.data);
        emit(state.copyWith(
            uploadImageState: RequestState.loaded, images: imagesList));
      }
    } else {
      emit(state.copyWith(uploadImageState: RequestState.error));
    }
  }

  removeImage(String image) {
    emit(state.copyWith(uploadImageState: RequestState.loading));
    imagesList.remove(image);
    emit(state.copyWith(
        images: imagesList, uploadImageState: RequestState.loaded));
  }

//** add product */

  Future addProduct(Product product, context) async {
    showUpdatesLoading(context);
    emit(state.copyWith(addProductsState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/product/add-Product'));
    request.fields.addAll({
      'ProviderId': currentProvider!.id.toString(),
      'CategoryId': product.categoryId.toString(),
      'BrandID': product.brandId.toString(),
      'Name': product.name,
      'Description': product.description,
      'Images': product.images,
      'Sizes': product.sizes,
      "discount": product.discount.toString(),
      'Price': product.price.toString(),
      'Calories': product.calories
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> addProduct");
    }
    if (response.statusCode == 200) {
      pop(context);

      // pop(context);

     pop(context);

      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم اضافة المنتج بنجاح ".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      // HomeCubit.get(context).getHomeProvider(context: context);
      emit(state.copyWith(addProductsState: RequestState.loaded, images: []));

      HomeCubit.get(context).getHomeProvider(context: context);


    } else {
      print(response.reasonPhrase);
    }
  }

//** delete product */
  Future deleteProduct({productId, context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(deleteProductState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/product/delete-product'));
    request.fields.addAll({'ProductId': productId.toString()});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} =======> deleteProduct");
    }
    if (response.statusCode == 200) {
      pop(context);
      pop(context);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم حذف  المنتج بنجاح".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      emit(state.copyWith(deleteProductState: RequestState.loaded));
      HomeCubit.get(context).getHomeProvider(context: context);
    } else {
      pop(context);
      emit(state.copyWith(deleteProductState: RequestState.error));
    }
  }

//** update product
  Future getDataProductForUpdate(int categoryId, String sizes, String colors,
      String images, discount) async {

    emit(state.copyWith(getDataForUpdateState: RequestState.loading));
    CategoryModel categoryModel =
        categories.firstWhere((element) => element.id == categoryId,orElse:()=>categories[0]);

    List<String> newImges = images.split("#");
    emit(state.copyWith(getDataForUpdateState: RequestState.loaded,
        categoryModel: categoryModel,
        colors: colors,
        sizes: sizes,
        images: newImges,
        discount: discount));
  }

  Future updateProduct(Product product, context) async {
    showUpdatesLoading(context);
    emit(state.copyWith(updateProductState: RequestState.loading));
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${ApiConstants.baseUrl}/product/update-product'));
    request.fields.addAll({
      'ProviderId': currentProvider!.id.toString(),
      'CategoryId': product.categoryId.toString(),
      'BrandID': product.brandId.toString(),
      'Name': product.name,
      'Description': product.description,
      'Images': product.images,
      'Sizes': product.sizes,
      "discount": product.discount.toString(),
      'Price': product.price.toString(),
      'Calories': product.calories,
      "id": product.id.toString()
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> updateProduct");
    }
    if (response.statusCode == 200) {
      pop(context);
      pop(context);
      // pushPageRoutName(context, navProvider);
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: "تم تعديل  المنتج بنجاح ".tr(),
            textStyle: TextStyle(
                fontFamily: AppFonts.caM, fontSize: 16, color: Colors.white),
          ));
      emit(state.copyWith(updateProductState: RequestState.loaded, images: []));
      HomeCubit.get(context).getHomeProvider(context: context);
      // ProviderCubit.get(context).getProductsByProviderId(page: 1,providerId: currentProvider!.id);
    } else {
      emit(state.copyWith(updateProductState: RequestState.error));
    }
  }

  changeCurrentPageSlider(int newIndex) {
    emit(state.copyWith(currentPageSlider: newIndex));
  }

  // ** search products

  Future searchProducts({textSearch, context, type}) async {
    emit(state.copyWith(searchProductsState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/product/search-products?textSearch=$textSearch&userId=${currentUser.id}&type=${type.toString()}'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("searchProducts========> ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          searchProductsState: RequestState.loaded,
          searchProducts: List<SearchProductResponse>.from((jsonData as List)
              .map((e) => SearchProductResponse.fromJson(e)))));
    } else {
      emit(state.copyWith(searchProductsState: RequestState.error));
    }
  }

//** add rate */
  Future addRateProduct({context, productId, comment, stare}) async {
    emit(state.copyWith(addRateProductState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.baseUrl + '/rates/add-rate'));
    request.fields.addAll({
      'productId': productId.toString(),
      'UserId': currentUser.id!,
      'Comment': comment,
      'Stare': stare.toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " ========> addRateProduct");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
              backgroundColor: Colors.green,
              message: jsonData["message"].toString().tr(),
              textStyle: TextStyle(
                  fontFamily: AppFonts.caM,
                  fontSize: 16,
                  color: Colors.white)));
      emit(state.copyWith(addRateProductState: RequestState.loaded));
      getRateProduct(productId: productId);
      HomeCubit.get(context).getHomeUser(context: context);
    } else {
      emit(state.copyWith(addRateProductState: RequestState.error));
    }
  }

//** get rate */
  Future getRateProduct({context, productId}) async {
    emit(state.copyWith(getRateProductState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(ApiConstants.baseUrl +
            '/rates/rates-product?productId=$productId'));

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " ========> getRateProduct");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          rates: List<RateResponse>.from(
              (jsonData as List).map((e) => RateResponse.fromJson(e)).toList()),
          getRateProductState: RequestState.loaded));
    } else {
      emit(state.copyWith(getRateProductState: RequestState.error));
    }
  }

  Future getProductsByProviderId({page, context, providerId}) async {
    emit(state.copyWith(searchProductsState: RequestState.loading));
    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/product/get-Products-By-providerId-page?page=${page.toString()}&providerId=${providerId.toString()}'));

    http.StreamedResponse response = await request.send();

    if (kDebugMode) {
      print("searchProducts========> ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          searchProductsState: RequestState.loaded,
          searchProducts: List<SearchProductResponse>.from((jsonData as List)
              .map((e) => SearchProductResponse.fromJson(e)))));
    } else {
      emit(state.copyWith(searchProductsState: RequestState.error));
    }
  }
}
