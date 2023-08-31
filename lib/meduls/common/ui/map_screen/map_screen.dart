import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/styles/style_widget.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/meduls/common/bloc/address_cubit/address_cubit.dart';
import 'package:hatlli/meduls/common/ui/map_screen/search_location_screen/search_location_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/back_button.dart';
import '../../models/address_model.dart';

class MapScreen extends StatefulWidget {
  final int type;
   AddressModel? addressModel;

   MapScreen({
    required this.type,
     this.addressModel,
  });
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude!, locData.longitude!),
    zoom: 14.4746,
  );

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String location = "Search Location";

  // String detailsAddress = "";

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllertext = TextEditingController();
  bool loading = false;

  late GoogleMapController? controllerMap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.type == 2) {
      AddressCubit.get(context).initMap(
          context: context,
          newLat: widget.addressModel!.lat,
          newLng: widget.addressModel!.lng);
      AddressCubit.get(context).detailsAddress == widget.addressModel!.description;
      _controllerName.text = widget.addressModel!.name != null
          ? widget.addressModel!.name!
          : "";
    }else{
       AddressCubit.get(context).initMap(
          context: context,
          newLat:locData.latitude,
          newLng:locData.longitude);
    }
  }

  void setInitialLocation({currentLat, currentLng}) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 19,
      target: LatLng(currentLat, currentLng),
    );
    controllerMap = await _controller.future;
    controllerMap!.setMapStyle(styleMap);
    controllerMap!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        // if (state.movMapState == RequestState.loaded) {
        //   _controllertext.text = AddressCubit.get(context).detailsAddress;
        // }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
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
                  // myLocationEnabled: true,
                  markers: AddressCubit.get(context).markers.values.toSet(),
                  onCameraIdle: (() {}),
                  onCameraMove: (object) {
                    // latitude = object.target.latitude;
                    // longitude = object.target.longitude;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    setInitialLocation(
                        currentLat: widget.addressModel != null
                            ? widget.addressModel!.lat
                            : locData.latitude,
                        currentLng: widget.addressModel != null
                            ?widget.addressModel!.lng
                            : locData.longitude);
                  },
                ),
              ),
              // const Center(
              //   child: Icon(Icons.location_pin,
              //       color: Palette.mainColor, size: 55),
              // ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "اختر موقع".tr(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "اضغط ضغطة مطولة لنقل الدبوس ووضعه علي موقعك"
                                          .tr(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.4),
                                          fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            // if(widget.type==1)
                            // widget.type != 0
                            //     ? TextField(
                            //         controller: _controllerName,
                            //         style: const TextStyle(color: Colors.black),
                            //         decoration: InputDecoration(
                            //           hintText: "اسم العنوان".tr(),
                            //           border: InputBorder.none,
                            //           focusedBorder: InputBorder.none,
                            //           enabledBorder: InputBorder.none,
                            //           errorBorder: InputBorder.none,
                            //           disabledBorder: InputBorder.none,
                            //           contentPadding: const EdgeInsets.only(
                            //               left: 15,
                            //               bottom: 2,
                            //               top: 11,
                            //               right: 15),
                            //           hintStyle: const TextStyle(fontSize: 12),
                            //         ),
                            //         onChanged: (v) {},
                            //       )
                            //     : const SizedBox(),
                            // const Divider(),
                            // TextField(
                            //   controller: _controllertext,
                            //   style: const TextStyle(color: Colors.black),
                            //   keyboardType: TextInputType.multiline,
                            //   maxLines: null,
                            //   decoration: InputDecoration(
                            //     hintText: "تفاصيل العنوان".tr(),
                            //     border: InputBorder.none,
                            //     focusedBorder: InputBorder.none,
                            //     enabledBorder: InputBorder.none,
                            //     errorBorder: InputBorder.none,
                            //     disabledBorder: InputBorder.none,
                            //     contentPadding: const EdgeInsets.only(
                            //         left: 15, bottom: 2, top: 11, right: 15),
                            //     hintStyle: const TextStyle(fontSize: 12),
                            //   ),
                            //   onChanged: (v) {},
                            // ),
                         
                          ],
                        ),
                      ),
                      AddressCubit.get(context).loading
                          ? CustomCircularProgress()
                          : MaterialButton(
                              onPressed: () async {
                                if (widget.type == 0) {
                                  /// ** create provider
                                  if (validate(context)) {
                                    // print(TripCubit.get(context).detailsAddress + "======> deta");
                                    AddressModel addressModel = AddressModel(
                                        defaultAddress: false,
                                        lat: AddressCubit.get(context).lat,
                                        description: AddressCubit.get(context).detailsAddress,
                                        lng: AddressCubit.get(context).lng);
                                    Navigator.of(context).pop(addressModel);
                                  }
                                } else if (widget.type == 1) {
                                  //** add address */
                                  if (isValidateAddAddress(context)) {
                                    AddressModel addressModel = AddressModel(
                                      defaultAddress: false,
                                      lat: AddressCubit.get(context).lat,
                                      description:AddressCubit.get(context).detailsAddress,
                                      name: _controllerName.text.isEmpty
                                          ? ""
                                          : _controllerName.text,
                                      lng: AddressCubit.get(context).lng,
                                    );
                                    AddressCubit.get(context).addAddress(
                                        addressModel,
                                        context: context,
                                        type: currentUser.role ==
                                                AppModel.userRole
                                            ? 1
                                            : 0);
                                  }
                                } else {
                                  //** update address */
                                  if (isValidateAddAddress(context)) {
                                    print(AddressCubit.get(context).lng);
                                    AddressModel addressModel = AddressModel(
                                      defaultAddress: false,
                                      lat: AddressCubit.get(context).lat,
                                      description:AddressCubit.get(context).detailsAddress,
                                      name: _controllerName.text.isEmpty
                                          ? ""
                                          : _controllerName.text,
                                      lng: AddressCubit.get(context).lng,
                                    );
                                    AddressCubit.get(context).updateAddress(
                                        addressModel,
                                        context: context,
                                        type: 0);
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
                            ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),

              // getSearchWidget()
              Align(
                alignment: Alignment.topRight,
                child: widget.type == 2
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40, right: 20),
                        child: BackButtonWidget(),
                      )
                    : SizedBox(),
              ),
              Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        // Create the SelectionScreen in the next step.
                        MaterialPageRoute(
                            builder: (context) => SearchLocationScreen()),
                      ).then((value) async {
                        List<Location> locations =
                            await locationFromAddress(value["description"]);
                        AddressCubit.get(context).lat = locations[0].latitude;
                        AddressCubit.get(context).lng = locations[0].longitude;

                        controllerMap!.animateCamera(CameraUpdate.newLatLngZoom(
                            LatLng(
                                locations[0].latitude, locations[0].longitude),
                            14));

                        _controllertext.text = value["description"];
                        AddressCubit.get(context).initMap(
                            context: context,
                            newLat: AddressCubit.get(context).lat,
                            newLng: AddressCubit.get(context).lng);
                        AddressCubit.get(context).getAddresses(
                            AddressCubit.get(context).lat,
                            AddressCubit.get(context).lng);

                        setState(() {});
                      });
                    },
                    child: Container(
                        height: 45,
                        margin: EdgeInsets.only(top: 26, left: 26, right: 26),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: decoration(color: Colors.white, 10),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            "ابحث في الخريطة".tr(),
                            textAlign: TextAlign.end,
                          )),
                          sizedWidth(20),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Palette.mainColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child:
                                    SvgPicture.asset("assets/icons/search.svg"),
                              ),
                            ),
                          )
                        ])),
                  ))
            ],
          ),
        );
      },
    );
  }

  bool validate(context) {
    if (AddressCubit.get(context).lat == 0.0 ||
        AddressCubit.get(context).lng == 0.0) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار موقع من علي الخريطة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }

  bool isValidateAddAddress(BuildContext context) {
    if (AddressCubit.get(context).lat == 0.0 ||
        AddressCubit.get(context).lng == 0.0) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار موقع من علي الخريطة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } 
    // else if (_controllertext.text.isEmpty) {
    //   showTopMessage(
    //       context: context,
    //       customBar: CustomSnackBar.error(
    //         backgroundColor: Colors.red,
    //         message: "اكتب  العنوان".tr(),
    //         textStyle: TextStyle(
    //             fontFamily: "font", fontSize: 16, color: Colors.white),
    //       ));
    //   return false;
    // }
     else {
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
