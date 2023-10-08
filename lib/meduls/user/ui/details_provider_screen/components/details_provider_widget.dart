import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/palette.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../provider/models/details_provider_response.dart';

class DetailsProverWidget extends StatefulWidget {
  final DetailsProviderResponse providerDetails;
  const DetailsProverWidget({super.key, required this.providerDetails});

  @override
  State<DetailsProverWidget> createState() => _DetailsProverWidgetState();
}

class _DetailsProverWidgetState extends State<DetailsProverWidget> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 16.4746,
  );

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController? controllerMap;
  void setInitialLocation() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 18,
      target: LatLng(locData.latitude ?? 33, locData.longitude ?? 29),
    );
    controllerMap = await _controller.future;
    controllerMap!.setMapStyle(styleMap);
    controllerMap!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      print(widget.providerDetails.provider!.lat);
      OrderCubit.get(context).drawPolyline(
          lat: widget.providerDetails.provider!.lat,
          lng: widget.providerDetails.provider!.lng,
          context: context,
          isState: false);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controllerMap.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Container(
            height: 75,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xfffafbfb),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Container(
                    height: 41,
                    width: 41,
                    decoration: BoxDecoration(
                        color: Palette.mainColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.asset(
                      'assets/images/marker.png',
                    )),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts(
                        title: widget.providerDetails.provider!.title,
                        family: AppFonts.moM,
                        size: 14,
                        textColor: Colors.black,
                        widget: FontWeight.normal),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/locationitem.svg"),
                        const SizedBox(
                          width: 5,
                        ),
                        Texts(
                            title: widget.providerDetails.provider!.addressName
                                .split(",")[0],
                            family: AppFonts.moM,
                            size: 12,
                            textColor: const Color(0xff4A4A4A),
                            widget: FontWeight.normal),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBarWidget(
                      rate: widget.providerDetails.provider!.rate,
                    ),
                    Texts(
                        title: "يبعد عنك".tr() +
                            (widget.providerDetails.provider!.distance)
                                .toStringAsFixed(2)
                                .toString() +
                            " km",
                        family: AppFonts.moM,
                        size: 12,
                        textColor: const Color(0xff4A4A4A),
                        widget: FontWeight.normal)
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 34,
        ),
        Row(
          children: [
            SvgPicture.asset("assets/icons/aboute_provider.svg"),
            const SizedBox(
              width: 5,
            ),
            Texts(
              title: "عن المزود".tr(),
              family: AppFonts.taM,
              size: 14,
              textColor: Color(0xff4A4A4A),
            )
          ],
        ),
        const SizedBox(
          height: 11,
        ),
        SizedBox(
          width: widthScreen(context),
          child: Text(
            widget.providerDetails.provider!.about,
            style: const TextStyle(
                fontFamily: AppFonts.caSi,
                fontSize: 12,
                color: Color(0xffA9A9AA),
                height: 1.5),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: .8,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Texts(
              title: "موقع المزود".tr(),
              family: AppFonts.taM,
              size: 14,
              textColor: Color(0xff4A4A4A),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return state.getlinsMapState == RequestState.loading
                ? CustomCircularProgress()
                : Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        initialCameraPosition: _kGooglePlex,
                        myLocationButtonEnabled: false,
                        buildingsEnabled: false,
                        compassEnabled: false,
                        markers:
                            Set<Marker>.of(OrderCubit.get(context).listMarker),
                        polylines: OrderCubit.get(context).polylinePoints,
                        onMapCreated: (controller) {
                          controllerMap = controller;
                          controllerMap!.setMapStyle(styleMap);
                          if (!_controller.isCompleted) {
                            _controller.complete(controller);
                          }
                        },
                      ),
                    ),
                  );
          },
        ),
        const SizedBox(
          height: 26,
        ),
      ]),
    );
  }
}
