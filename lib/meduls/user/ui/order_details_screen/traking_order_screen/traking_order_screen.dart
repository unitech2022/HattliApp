import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/custom_button.dart';

class TrackingOrderScreen extends StatefulWidget {
  final double lat, lng;
  const TrackingOrderScreen({super.key, required this.lat, required this.lng});

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 16.4746,
  );

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController? controllerMap;
  void setInitialLocation() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 12,
      target: LatLng(locData.latitude ?? 33, locData.longitude ?? 29),
    );

    controllerMap = await _controller.future;

    controllerMap!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  final _controllerPrice = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerPrice.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      print(widget.lat.toString() +
          "," +
          widget.lng.toString() +
          "=======>  lat" +
          locData.latitude.toString() +
          "," +
          locData.longitude.toString());
      OrderCubit.get(context)
          .drawPolyline(lat: widget.lat, lng: widget.lng, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
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
                markers: Set<Marker>.of(OrderCubit.get(context).listMarker),
                polylines: OrderCubit.get(context).polylinePoints,
                onMapCreated: (controller) {
                  controllerMap = controller;
                  controllerMap!.setMapStyle(styleMap);
                  if (!_controller.isCompleted)
                    _controller.complete(controller);
                },
              ),
              currentUser.role == AppModel.userRole ||
                      state.orderDetailsResponse!.order!.status == 3
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                            title: orderStatusText[
                                    state.orderDetailsResponse!.order!.status]
                                .tr(),
                            onPressed: () {
                              if (state.orderDetailsResponse!.order!.status ==
                                      0 &&
                                  state.orderDetailsResponse!.order!.type ==
                                      1 &&
                                  currentUser.role == AppModel.providerRole) {
                                confirmManualOrder(context,
                                    state.orderDetailsResponse!.order!.id);
                              } else {
                                OrderCubit.get(context).updateOrder(
                                    state.orderDetailsResponse!.order!.status +
                                        1,
                                    state.orderDetailsResponse!.order!.id,
                                    1,
                                    context: context);
                              }
                            }),
                      ),
                    ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      backgroundColor:
                          Colors.black.withOpacity(.2), // <-- Button color
                    ),
                  ),
                ),
              ),
              currentUser.role == AppModel.providerRole
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 100, left: 20, right: 20),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.0, color: const Color(0xfff6f6f7)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0f000000),
                              offset: Offset(1, 1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            openGoogleMapLocation(
                                lat: widget.lat, lng: widget.lng);
                          },
                          icon: Icon(Icons.location_on_rounded,
                              size: 30, color: Colors.black),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        );
      },
      listener: (BuildContext context, OrderState state) {
        if (state.getlinsMapState == RequestState.loaded) {}
      },
    );
  }

  Future<dynamic> confirmManualOrder(BuildContext context, orderId) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  width: double.infinity,
                  // height: heightScreen(context) / 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // sizedHeight(15),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon: Icon(Icons.close, color: Colors.black))
                        ],
                      ),

                      Row(
                        children: [
                          Texts(
                            title: "اكتب السعر".tr(),
                            textColor: Colors.black,
                            size: 20,
                            widget: FontWeight.bold,
                            family: AppFonts.taB,
                          ),
                        ],
                      ),

                      sizedHeight(20),

                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: .8)),
                        child: TextField(
                          controller: _controllerPrice,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: "اكتب سعر الطلب  + قيمة التوصيل".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: AppFonts.taM),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      state.updateOrderState == RequestState.loading
                          ? CustomCircularProgress(
                              size: Size(30, 30),
                              strokeWidth: 4,
                            )
                          : CustomButton(
                              onPressed: () {
                                OrderCubit.get(context)
                                    .confirmManualOrder(
                                        _controllerPrice.text.trim(), orderId,
                                        context: context)
                                    .then((value) {
                                  pop(context);
                                  _controllerPrice.clear();
                                });
                              },
                              title: 'ارسال'.tr(),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
