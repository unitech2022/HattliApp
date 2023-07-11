import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/meduls/common/bloc/address_cubit/address_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../bloc/app_cubit/app_cubit.dart';
import '../../models/address_model.dart';

class MapScreen extends StatefulWidget {
  final int type;

  const MapScreen({this.type = 0});
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 14.4746,
  );

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var latitude;
  String location = "Search Location";
  var longitude;

  // String detailsAddress = "";

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllertext = TextEditingController();
  bool loading = false;
  late GoogleMapController? controllerMap;
  void setInitialLocation() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 19,
      target: LatLng(locData.latitude ?? 33, locData.longitude ?? 29),
    );
    controllerMap = await _controller.future;
    controllerMap!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state.movMapState == RequestState.loaded) {
          _controllertext.text = AppCubit.get(context).detailsAddress;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 270.0),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: MapScreen._kGooglePlex,
                  myLocationButtonEnabled: false,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  onCameraIdle: (() {
                    AppCubit.get(context).getAddresses(latitude, longitude);
                  }),
                  onCameraMove: (object) {
                    latitude = object.target.latitude;
                    longitude = object.target.longitude;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    setInitialLocation();
                  },
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: Icon(Icons.location_pin,
                      color: Palette.mainColor, size: 55),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        // height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Palette.mainColor,
                                  size: 55,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "اختر موقع".tr(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(),
                            // if(widget.type==1)
                            widget.type != 0 
                                ? TextField(
                                    controller: _controllerName,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: 'اسم العنوان'.tr(),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          left: 15,
                                          bottom: 2,
                                          top: 11,
                                          right: 15),
                                      hintStyle: const TextStyle(fontSize: 12),
                                    ),
                                    onChanged: (v) {},
                                  )
                                : const SizedBox(),
                            const Divider(),
                            TextField(
                              controller: _controllertext,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'تفاصيل العنوان'.tr(),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 2, top: 11, right: 15),
                                hintStyle: const TextStyle(fontSize: 12),
                              ),
                              onChanged: (v) {},
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (widget.type == 0) {
                            if (validate(context)) {
                              // print(TripCubit.get(context).detailsAddress + "======> deta");
                              AddressModel addressModel = AddressModel(
                                  defaultAddress: false,
                                  lat: latitude,
                                  description: _controllertext.text,
                                  lng: longitude);
                              Navigator.of(context).pop(addressModel);
                            }
                          } else {
                            if (isValidateAddAddress(context)) {
                              AddressModel addressModel = AddressModel(
                                  defaultAddress: false,
                                  lat: latitude,
                                  description: _controllertext.text,
                                  name: _controllerName.text,
                                  lng: longitude);
                              AddressCubit.get(context)
                                  .addAddress(addressModel,context: context,type: widget.type);
                            }
                          }
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          color: Palette.mainColor,
                          child: Center(
                            child: Text(
                              "تآكيد الموقع".tr(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // getSearchWidget()
            ],
          ),
        );
      },
    );
  }

  bool validate(context) {
    if (latitude == null || longitude == null) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار موقع من علي الخريطة",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }

  bool isValidateAddAddress(BuildContext context) {
    if (latitude == null || longitude == null) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار موقع من علي الخريطة",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    }
    if (_controllerName.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم العنوان ",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }

  // Widget getSearchWidget() {
  //   return //search autoconplete input
  //       Positioned(
  //           //search input bar
  //           top: 10,
  //           child: InkWell(
  //               onTap: () async {
  //                 var place = await PlacesAutocomplete.show(
  //                     context: context,
  //                     apiKey: ApiConstants.googleKey,
  //                     mode: Mode.overlay,
  //                     types: [],
  //                     strictbounds: false,
  //                     components: [Component(Component.country, 'np')],
  //                     //google_map_webservice package
  //                     onError: (err) {
  //                       print(err);
  //                     });

  //                 if (place != null) {
  //                   setState(() {
  //                     location = place.description.toString();
  //                   });

  //                   //form google_maps_webservice package
  //                   final plist = GoogleMapsPlaces(
  //                     apiKey: ApiConstants.googleKey,
  //                     apiHeaders: await GoogleApiHeaders().getHeaders(),
  //                     //from google_api_headers package
  //                   );
  //                   String placeid = place.placeId ?? "0";
  //                   final detail = await plist.getDetailsByPlaceId(placeid);
  //                   final geometry = detail.result.geometry!;
  //                   latitude = geometry.location.lat;
  //                   longitude = geometry.location.lng;
  //                   var newlatlang = LatLng(latitude, longitude);
  //                   final c = await _completer.future;
  //                   //move map camera to selected place with animation
  //                   c.animateCamera(CameraUpdate.newCameraPosition(
  //                       CameraPosition(target: newlatlang, zoom: 17)));
  //                 }
  //               },
  //               child: Padding(
  //                 padding: EdgeInsets.all(15),
  //                 child: Card(
  //                   child: Container(
  //                       padding: EdgeInsets.all(0),
  //                       width: MediaQuery.of(context).size.width - 40,
  //                       child: ListTile(
  //                         title: Text(
  //                           location,
  //                           style: TextStyle(fontSize: 18),
  //                         ),
  //                         trailing: Icon(Icons.search),
  //                         dense: true,
  //                       )),
  //                 ),
  //               )));
  // }
}
