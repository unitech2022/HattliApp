import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';

import 'package:hatlli/meduls/provider/models/review_model.dart';
import 'package:hatlli/meduls/provider/ui/statistics_screen/statistics_screen.dart';
import 'package:hatlli/meduls/user/models/Response_total_order.dart';
import 'package:http/http.dart' as http;
part 'statist_state.dart';

class StatistCubit extends Cubit<StatistState> {
  StatistCubit() : super(StatistState());
  static StatistCubit get(context) => BlocProvider.of<StatistCubit>(context);

  changeCurrentIndexNav(int newIndex) {
    emit(state.copyWith(currentIndexTap: newIndex));
  }

  Future initDates({context}) async {
    emit(state.copyWith(
        startDateStatist: formatDate(
          DateTime.now(),
        ),
        endDateStatist: formatDate(DateTime.now().subtract(Duration(days: 7)))));

    getReviewProvider(
        context: context, start: formatDate(DateTime.now().subtract(Duration(days: 7))), type: 0);
  }

  changeTypeTimeStatist(int newValue) {
    emit(state.copyWith(typeStatistTime: newValue));
  }

  List<SalesData> data = [];

// List<SalesData> data = [
//   SalesData('الطلبات', 100),
//   SalesData('المبيعات', 28),

  // SalesData('Mar', 34),
  // SalesData('Apr', 32),
  // SalesData('May', 40)

  // SalesData('Mar', 34),
  // SalesData('Apr', 32),
  // SalesData('May', 40)

  changeEndDateStatist(String start, int type) {
    DateTime? endDate;
    DateTime startDate = DateFormat('yyyy-MM-dd', "en").parse(start);
    emit(state.copyWith(startDateStatist: formatDate(startDate)));
    if (type == 0) {
      endDate = startDate.subtract(Duration(days: 7));
    } else if (type == 1) {
      endDate = startDate.subtract(Duration(days: 30));
    } else {
      endDate = startDate.subtract(Duration(days: 360));
    }

    emit(state.copyWith(endDateStatist: formatDate(endDate)));
  }

  Future getReviewProvider({context, start, type}) async {
    // showUpdatesLoading(context);
    emit(state.copyWith(getReviewsProviderState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiConstants.baseUrl + '/provider/review-provider'));
    request.fields.addAll(
        {'userId': currentUser.id!, 'from': start, 'to': type.toString()});

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "   =======> getReviewProvider");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      ReviewModel reviewModel = ReviewModel.fromJson(jsonData);
      print(reviewModel.ordersCanceled);

      data.add(SalesData("الطلبات", reviewModel.ordersCanceled));
      data.add(SalesData("المبيعات", reviewModel.ordersAccepted));
      data.add(SalesData("المنتجات", reviewModel.products));

      emit(state.copyWith(
          getReviewsProviderState: RequestState.loaded,
          reviewModel: reviewModel));
    } else {
      emit(state.copyWith(getReviewsProviderState: RequestState.error));
    }
  }

  // ** my wallet
  Future balanceWithdrawal({mony, type, context, start, typeView}) async {
    emit(state.copyWith(balanceWithdrawal: RequestState.loading));
    // var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            ApiConstants.baseUrl + '/provider/BalanceWithdrawal-provider'));
    request.fields.addAll(
        {'userId': currentUser.id!, 'mony': mony, 'type': type.toString()});

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + " =======> balanceWithdrawal");
    if (response.statusCode == 200) {
      emit(state.copyWith(balanceWithdrawal: RequestState.loaded));
      pop(context);
      showDialogSuccess(
          context: context,
          message: "سيقوم موظفينا بالتحقق و ارسال لمبلغ في غضون 24 ساعة".tr());
      await getReviewProvider(context: context, start: start, type: typeView);
    } else {
      emit(state.copyWith(balanceWithdrawal: RequestState.error));
    }
  }

  changeTypeBlanca(bool newValue) {
    emit(state.copyWith(isAllMony: newValue));
  }

  Future getAllOrders({providerId}) async {
    emit(state.copyWith(getAllOrdersState: RequestState.loading));
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'Get', Uri.parse(ApiConstants.baseUrl + '/orders/get-Orders-by-marketId?marketId=${providerId.toString()}'));
   
 request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "   =======> getAllOrders");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      emit(state.copyWith(
          getAllOrdersState: RequestState.loaded,
          allOrders: ResponseTotalOrder.fromJson(jsonData)));
    } else {
      emit(state.copyWith(getAllOrdersState: RequestState.error));
    }
  }
}
