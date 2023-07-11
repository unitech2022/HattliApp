import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/custom_button.dart';

class TrackingOrderScreen extends StatefulWidget {
  const TrackingOrderScreen({super.key});

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 14.4746,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
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
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
              ),
              state.orderDetailsResponse!.order!.status == 3
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomButton(
                            title:  state.orderDetailsResponse!.order!.status == 1?"تجهيز الطلب": "تسليم الطلب",
                            onPressed: () {
                              OrderCubit.get(context).updateOrder(
                                 state.orderDetailsResponse!.order!.status+1, state.orderDetailsResponse!.order!.id, 1,
                                  context: context);
                            }),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
