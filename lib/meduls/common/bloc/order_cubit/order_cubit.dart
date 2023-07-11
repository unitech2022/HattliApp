import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/utils.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import 'package:http/http.dart' as http;
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../models/order_response.dart';
import '../../models/polyine_response.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());
  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);

  changeCurrentIndexNav(int newIndex) {
    emit(state.copyWith(currentIndexTap: newIndex));
  }

// ** add order
  Future addOrder(int payment, {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(addOrderState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/orders/add-order'));

    request.fields.addAll({
      // 'providerId': '4',
      'UserId': currentUser.id!,
      'payment': payment.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> addOrder");
    }
    if (response.statusCode == 200) {
      pop(context);
      CartCubit.get(context).cartsFound.clear();
      pushPageRoutName(context, navUser);
      showDialogSuccess(context: context, message: "تم ارسال الطلب بنجاح");

      emit(state.copyWith(addOrderState: RequestState.loaded));
      // await getCarts(isState: false);
    } else {
      pop(context);
      emit(state.copyWith(addOrderState: RequestState.error));
    }
  }

// ** update order

  List<String> textOrderStatus = [
    "في انتظار التأكيد",
    "تم تأكيد الطلب بنجاح",
    "جارى التجهيز",
    "تم التسليم",
    "تم الغاء الطلب"
  ];
  Future updateOrder(status, id, sender, {context}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(updateOrderState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${ApiConstants.baseUrl}/orders/update-Order-status'));
    request.fields.addAll({
      'orderId': id.toString(),
      'status': status.toString(),
      "sender": sender.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> updateOrder");
    }
    if (response.statusCode == 200) {
      pop(context);

      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: textOrderStatus[status],
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      getOrderDetails(id);
      emit(state.copyWith(updateOrderState: RequestState.loaded));
      // getCarts(isState: false);
    } else {
      emit(state.copyWith(updateOrderState: RequestState.error));
    }
  }

// ** get order details
  Future getOrderDetails(id, {context}) async {
    emit(state.copyWith(getOrderDetailsState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '${ApiConstants.baseUrl}/orders/get-OrderDetails?orderId=$id'));
    request.fields.addAll({'orderId': id.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ======> getOrderDetails");
    }
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      emit(state.copyWith(
          getOrderDetailsState: RequestState.loaded,
          orderDetailsResponse: OrderDetailsResponse.fromJson(jsonData)));
      // getCarts(isState: false);
    } else {
      emit(state.copyWith(getOrderDetailsState: RequestState.error));
    }
  }

  PolylineResponse polylineResponse = PolylineResponse();

  Set<Polyline> polylinePoints = {};
  void drawPolyline({lat, lng}) async {
    var response = await http.post(Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json?key=${AppModel.apiKey}&units=metric&origin=${locData.latitude},${locData.longitude}&destination=$lat,$lng&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    // totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    // totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0;
        i < polylineResponse.routes![0].legs![0].steps!.length;
        i++) {
      polylinePoints.add(Polyline(
          polylineId: PolylineId(
              polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
          points: [
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lng!),
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lng!),
          ],
          width: 3,
          color: Colors.red));
    }
  }
}
