import 'dart:convert';
import 'dart:ui' as ui;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/utils.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
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

  String detailsAddress = "";
  double lat = 0.0;
  double lng = 0.0;
  bool loading = false;

//** get address */

  Future getAddressApi({context, type}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(getAddressState: RequestState.loading));
    if (type == 2) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/address/get-address-by-userId?UserId=${currentUser.id}'));

      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print("${response.statusCode} ========>getAddress");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        AddressModel addressModel = AddressModel.fromJson(jsonData);
        lat = addressModel.lat!;
        lng = addressModel.lng!;
        initMap(newLat: addressModel.lat!, newLng: addressModel.lng);
        getAddresses(addressModel.lat!, addressModel.lng!);
        pop(context);
        emit(state.copyWith(
            getAddressState: RequestState.loaded, address: addressModel));
      } else {
        getAddresses(locData.latitude!, locData.longitude!);
        pop(context);
        emit(state.copyWith(getAddressState: RequestState.error));
      }
    } else {
      initMap(
          context: context,
          newLat: locData.latitude,
          newLng: locData.longitude);
      getAddresses(locData.latitude!, locData.longitude!);
      emit(state.copyWith(getAddressState: RequestState.loaded));
    }
  }

  //** */ add address
  Future addAddress(AddressModel addressModel, {context, type}) async {
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
      pop(context);
      emit(state.copyWith(addAddressState: RequestState.loaded));
      if (currentUser.role == AppModel.userRole) {
        HomeCubit.get(context).getHomeUser(context: context);
      } else {
        HomeCubit.get(context).getHomeProvider(context: context);
      }
    } else {
      pop(context);
      emit(state.copyWith(addAddressState: RequestState.error));
    }
  }

  //*** */ update address
  Future updateAddress(AddressModel addressModel, {context, type}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(addAddressState: RequestState.loading));
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiConstants.baseUrl}/address/update-address'));
    request.fields.addAll({
      'UserId': currentUser.id!,
      'Description': addressModel.description!,
      'Lat': addressModel.lat.toString(),
      'Lng': addressModel.lng.toString(),
      'Name': addressModel.name!
    });

    http.StreamedResponse response = await request.send();
    if (kDebugMode) {
      print("${response.statusCode} ========> UpdateAddress");
    }
    if (response.statusCode == 200) {
      pop(context);
      pop(context);
      pushPageRoutName(context, navUser);
      emit(state.copyWith(addAddressState: RequestState.loaded));
    } else {
      pop(context);
      emit(state.copyWith(addAddressState: RequestState.error));
    }
  }

  // ** search location
  List<dynamic> placeList = [];

  Future getSuggestion(String input) async {
    emit(state.copyWith(searchLocationState: RequestState.loading));
    String kPLACES_API_KEY = ApiConstants.apiGoogleMapKey;
    // String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      placeList = json.decode(response.body)['predictions'];
      emit(state.copyWith(searchLocationState: RequestState.loaded));
    } else {
      // throw Exception('Failed to load predictions');
      emit(state.copyWith(searchLocationState: RequestState.error));
    }
  }

  Future getAddresses(double lat, double long) async {
    loading = true;
    emit(state.copyWith(movMapState: RequestState.loading));
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long,
        localeIdentifier: AppModel.lang);
    // print(placemarks[0]);
    detailsAddress =
        "${placemarks[0].name},${placemarks[0].street},${placemarks[0].administrativeArea},${placemarks[0].subAdministrativeArea} ,${placemarks[0].locality} ,${placemarks[0].subLocality}";

    // print( detailsAddress+
    // "====== > address");

    loading = false;
    emit(state.copyWith(movMapState: RequestState.loaded));
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  initMap({context, newLat, newLng}) async {
    markers.clear();
     emit(state.copyWith(initMapState: RequestState.loading));


    Uint8List markerIcon =
        await getBytesFromAsset('assets/images/pin.png', 120);
    markers[MarkerId('place_name')] = Marker(
        draggable: true,
        markerId: MarkerId('Marker'),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(newLat, newLng),
        onTap: () {
          print("object");
        },
        onDragEnd: (newPosition) {
          lat = newPosition.latitude;
          lng = newPosition.longitude;
          print(lat);
          getAddresses(newPosition.latitude, newPosition.longitude);
        });

  getAddresses(newLat, newLng);

  emit(state.copyWith(initMapState: RequestState.loaded));
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
}
