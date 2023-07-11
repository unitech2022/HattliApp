import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/notification_model.dart';

import 'package:http/http.dart' as http;

import '../../../../core/utils/api_constatns.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());
  static NotificationCubit get(context) =>
      BlocProvider.of<NotificationCubit>(context);

  // ** get alerts
  Future getAlerts({context, isState}) async {
    emit(state.copyWith(getAlertsState: RequestState.loading));

    var request = http.Request(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/alerts/get-Alerts?UserId=${currentUser.id}'));

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> getAlerts");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      emit(state.copyWith(
          getAlertsState: RequestState.loaded,
          alertResponse: AlertResponse.fromJson(jsonData)));
      // getCarts(isState: false);
    } else {
      emit(state.copyWith(getAlertsState: RequestState.error));
    }
  }

// *** view alert
  Future viewAlert(alertId, {context}) async {
    // emit(state.copyWith(viewAlertState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/alerts/view-Alert'));
    request.fields
        .addAll({'alertId': alertId.toString(), 'UserId': currentUser.id!});

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> viewAlert");
    }
    if (response.statusCode == 200) {
      // emit(state.copyWith(viewAlertState: RequestState.loaded));
      // getCarts(isState: false);
      if (currentUser.role == AppModel.userRole) {
        HomeCubit.get(context).getHomeUser();
      } else {
        HomeCubit.get(context).getHomeProvider();
      }
    } else {
      emit(state.copyWith(viewAlertState: RequestState.error));
    }
  }
}
