import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/utils.dart';
import 'package:hatlli/meduls/common/models/address_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(const AddressState());
  static AddressCubit get(context) => BlocProvider.of<AddressCubit>(context);

  //** */ add address
  Future addAddress(AddressModel addressModel, {context,type}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(addAddressState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/address/add-address'));
    request.fields.addAll({
      'UserId': currentUser.id!,
      'Description': addressModel.description!,
      'Lat': addressModel.lat.toString(),
      'Lng': addressModel.lng.toString(),
      'Name': addressModel.name!
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ========> addAddress");
    }
    if (response.statusCode == 200) {
      pop(context);
      pushPageRoutName(context,type==1? navUser:navProvider);
      emit(state.copyWith(addAddressState: RequestState.loaded));
    } else {
      pop(context);
      emit(state.copyWith(addAddressState: RequestState.error));
    }
  }
}
