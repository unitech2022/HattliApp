import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../models/favoraite.dart';
import 'package:http/http.dart' as http;
part 'favoraite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState());
  static FavoriteCubit get(context) => BlocProvider.of<FavoriteCubit>(context);
  Map<int, int> favFound = {};

// ** add favorite
  Future addFav(productId, {context}) async {
    favFound.containsValue(productId)
        ? favFound.remove(productId)
        : favFound.addAll({productId: productId});
    emit(state.copyWith(addFavState: RequestState.loading));

    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/fav/add-favorite'));
    request.fields
        .addAll({'UserId': currentUser.id!, 'ProductId': productId.toString()});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> addFav");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(addFavState: RequestState.loaded));
    } else {
      emit(state.copyWith(addFavState: RequestState.error));
    }
  }

// ** delete fav
  Future deleteFav({context, favId}) async {
    emit(state.copyWith(deleteFavState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/fav/delete-favorite'));
    request.fields.addAll({'favoriteId': favId.toString()});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> deleteFav");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(deleteFavState: RequestState.loaded));
      getFavorites();
    } else {
      emit(state.copyWith(deleteFavState: RequestState.error));
    }
  }

//**  get Favorites */
  Future getFavorites({isState = true}) async {
    emit(state.copyWith(getFavState: RequestState.loading));

    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/fav/get-favorites?userId=${currentUser.id}'));

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======>  getFavorites");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      List<FavoriteResponse> favs = List<FavoriteResponse>.from(
          (jsonData as List).map((e) => FavoriteResponse.fromJson(e)));
      favFound.clear();
      for (var element in favs) {
        favFound
            .addAll({element.favorite.productId!: element.favorite.productId!});
      }
      emit(state.copyWith(getFavState: RequestState.loaded, favorites: favs));
    } else {
      emit(state.copyWith(getFavState: RequestState.error));
    }
  }
}
