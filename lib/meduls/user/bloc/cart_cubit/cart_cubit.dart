import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/user/models/cart_model.dart';

import '../../../../core/enums/loading_status.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/api_constatns.dart';
import '../../models/cart_response.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);
  Map<int, int> cartsFound = {};

// ** add cart
  Future addCart(CartModel cartModel, {context}) async {
    cartsFound.containsValue(cartModel.productId)
        ? cartsFound.remove(cartModel.productId)
        : cartsFound.addAll({cartModel.productId: cartModel.productId});
    emit(state.copyWith(addCartState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/cart/add-cart'));
    request.fields.addAll({
      'Quantity': cartModel.quantity.toString(),
      'Status': '0',
      'Cost': cartModel.cost.toString(),
      'UserId': currentUser.id!,
      'productId': cartModel.productId.toString(),
      'ProviderId': cartModel.providerId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> addCart");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(addCartState: RequestState.loaded));
      await getCarts(isState: false);
    } else {
      emit(state.copyWith(addCartState: RequestState.error));
    }
  }

// ** delete cart
  Future deleteCart({cartId, context, providerId, productId}) async {
    emit(state.copyWith(deleteCartState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/cart/delete-cart'));
    request.fields.addAll({'cartId': cartId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> addCart");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(deleteCartState: RequestState.loaded));
      cartsFound.remove(productId);
      getCarts(isState: true);
      ProviderCubit.get(context)
          .getProviderDetails(providerId: providerId, context: context);
    } else {
      emit(state.copyWith(deleteCartState: RequestState.error));
    }
  }

// ** update cart
  Future updateCart(quantity, id, {context}) async {
    emit(state.copyWith(updateCartState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${ApiConstants.baseUrl}/cart/update-cart'));
    request.fields
        .addAll({'Quantity': quantity.toString(), 'id': id.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> updateCart");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(updateCartState: RequestState.loaded));
      getCarts(isState: false);
    } else {
      emit(state.copyWith(updateCartState: RequestState.error));
    }
  }

  List<int> quantities = [];
  List<double> prices = [];
  double total = 0.0;
//** get cart */
  Future getCarts({isState = true}) async {
    total = 0.0;
    if (isState) {
      quantities = [];
      prices = [];
      cartsFound.clear();
      emit(state.copyWith(getCartsState: RequestState.loading));
    }
    var headers = {'Authorization': token};

    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/cart/get-carts?UserId=${currentUser.id}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> getCarts");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      CartResponse cartResponse = CartResponse.fromJson(jsonData);
      for (CartDetails element in cartResponse.carts!) {
        cartsFound.addAll({element.product.id: element.product.id});
        quantities.add(element.cart.quantity);
        prices.add(element.cart.cost);
      }

      total = cartResponse.totalCost!;
      emit(state.copyWith(
          getCartsState: RequestState.loaded,
          cartResponse: cartResponse,
          quantities: quantities,
          prices: prices));
    } else {
      emit(state.copyWith(getCartsState: RequestState.error));
    }
  }

  add(index, price, id) {
    // total = 0.0;
    emit(state.copyWith(addCartState: RequestState.loading));
    quantities[index]++;
    prices[index] = price * quantities[index];
    // print("${quantities[index].toString()} - ${price.toString()}");

    // for (var element in prices) {
    //   total += element;
    // }
    updateCart(quantities[index], id);
    emit(state.copyWith(addCartState: RequestState.loaded));
  }

  mins(index, price, id) {
    // total = 0.0;
    emit(state.copyWith(minusQuantityState: RequestState.loading));
    if (quantities[index] > 1) {
      quantities[index]--;
      prices[index] = price * quantities[index];
      // print("${quantities[index].toString()} - ${price.toString()}");

      // for (var element in prices) {
      //   total += element;
      // }
      // total = prices.sum;
      updateCart(quantities[index], id);
    }

    emit(state.copyWith(minusQuantityState: RequestState.loaded));
  }
}
