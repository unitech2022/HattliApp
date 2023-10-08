import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import '../../../../core/utils/app_model.dart';
import '../components/search_container_widget.dart';
import '../search_products_screen/search_products_screen.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  late GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void dispose() {
    // TODO: implement dispose
    // mapController!.dispose();
    super.dispose();

  }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
  //   zoom: 14.4746,
  // );

  List<Marker> list = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if (state.getHomeUserState == RequestState.loaded) {
        //   if (state.homeUserResponse!.address != null) {
        //     mapController.animateCamera(CameraUpdate.newLatLngZoom(
        //         LatLng(state.homeUserResponse!.address!.lat!,
        //             state.homeUserResponse!.address!.lng!),
        //         14));
        //   }
        // }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                // myLocationEnabled: true,



                initialCameraPosition: CameraPosition(
                  target: LatLng(
                   state.homeUserResponse!=null &&   state.homeUserResponse!.address != null
                          ? state.homeUserResponse!.address!.lat!
                          : locData.latitude!,
                    state.homeUserResponse!=null &&  state.homeUserResponse!.address != null
                          ? state.homeUserResponse!.address!.lng!
                          : locData.longitude!),
                  zoom: 16.4746,
                ),
                markers: Set<Marker>.of(state.markers),

                // markers: markers,
                // polylines: state.polyines,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 70, left: 16, right: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      ContainerSearchWidget(
                          text: "",
                          onTap: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            pushPage(context,
                                SearchProductsScreen(textSearch: value));
                          }),

                      //=======
                    ],
                  ),
                ),
              ),
           Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: IconButton(icon: Icon(Icons.location_searching_outlined,), onPressed: () {

                mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                            LatLng(
                                
                        state.homeUserResponse!.address != null
                            ? state.homeUserResponse!.address!.lat!
                            : locData.latitude!,
                        state.homeUserResponse!.address != null
                            ? state.homeUserResponse!.address!.lng!
                            : locData.longitude!),
                              16.4746,));
               },)),
           )
           
            ],
          ),
        );
      },
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller)async {
    _controller.complete(controller);

    // 
 
      
      mapController = await _controller.future;
      mapController!.setMapStyle(styleMap);

    




    // var marker = Marker(
    //   onTap: () {
    //     showBottomSheetWidget(
    //         context,
    //         Container(
    //           padding: const EdgeInsets.only(top: 32, left: 18, right: 18),
    //           decoration: const BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(25),
    //                   topRight: Radius.circular(25)),
    //               color: Colors.white),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               const Texts(
    //                   title: "تفاصيل المزود",
    //                   family: AppFonts.moM,
    //                   size: 14,
    //                   textColor: Color(0xff4A4A4A),
    //                   widget: FontWeight.normal),
    //               const SizedBox(
    //                 height: 30,
    //               ),
    //               Container(
    //                 height: 75,
    //                 padding: const EdgeInsets.all(5),
    //                 decoration: BoxDecoration(
    //                   color: const Color(0xfffafbfb),
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Container(
    //                         height: 41,
    //                         width: 41,
    //                         decoration: BoxDecoration(
    //                             color: Palette.mainColor,
    //                             borderRadius: BorderRadius.circular(8)),
    //                         child: SvgPicture.asset(
    //                           "assets/icons/icon_logo.svg",
    //                         )),
    //                     const SizedBox(
    //                       width: 15,
    //                     ),
    //                     Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         const Texts(
    //                             title: "اسم المزود",
    //                             family: AppFonts.moM,
    //                             size: 14,
    //                             textColor: Colors.black,
    //                             widget: FontWeight.normal),
    //                         Row(
    //                           children: [
    //                             SvgPicture.asset(
    //                                 "assets/icons/locationitem.svg"),
    //                             const SizedBox(
    //                               width: 5,
    //                             ),
    //                             const Texts(
    //                                 title: "الرياض",
    //                                 family: AppFonts.moM,
    //                                 size: 12,
    //                                 textColor: Color(0xff4A4A4A),
    //                                 widget: FontWeight.normal),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     const Spacer(),
    //                     const Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         RatingBarWidget(
    //                           rate: 3.0,
    //                         ),
    //                         Texts(
    //                             title: "يبعد عنك    2.5km",
    //                             family: AppFonts.moM,
    //                             size: 12,
    //                             textColor: Color(0xff4A4A4A),
    //                             widget: FontWeight.normal),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 27,
    //               ),
    //               SizedBox(
    //                 width: context.wSize,
    //                 height: AppSize.s50,
    //                 child: ElevatedButton(
    //                   onPressed: () {
    //                     pop(context);
    //                     pushPageRoutName(context, detailsProvider);
    //                   },
    //                   style: ButtonStyle(
    //                     backgroundColor: MaterialStateProperty.all<Color>(
    //                       // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
    //                       Palette.mainColor,
    //                     ),
    //                     elevation: MaterialStateProperty.all(10),
    //                     shape: MaterialStateProperty.resolveWith((states) {
    //                       if (!states.contains(MaterialState.pressed)) {
    //                         return const RoundedRectangleBorder(
    //                           borderRadius: AppRadius.r10,
    //                           side: BorderSide.none,
    //                         );
    //                       }
    //                       return const RoundedRectangleBorder(
    //                         borderRadius: AppRadius.r10,
    //                       );
    //                     }),
    //                   ),
    //                   child: Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Text(
    //                         "المزيد من التفاصيل",
    //                         style: context.titleM.copyWith(
    //                           fontSize: 14,
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontFamily: AppFonts.moR,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         width: 40,
    //                       ),
    //                       const Icon(
    //                         Icons.arrow_forward,
    //                         color: Colors.white,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 27,
    //               ),
    //             ],
    //           ),
    //         ));
    //   },
    //   markerId: const MarkerId('place_name'),
    //   position: const LatLng(37.43296265331129, -122.08832357078792),

    //   // icon: BitmapDescriptor.,
    //   // infoWindow: const InfoWindow(
    //   //   title: 'title',
    //   //   snippet: 'address',
    //   // ),
    // );

    // setState(() {
    //   markers[const MarkerId('place_name')] = marker;
    // });
  }
}

class CircleImageNetwork extends StatelessWidget {
  final double height, width;
  final String image, imageError;
  final Color colorBackground;
  const CircleImageNetwork({
    super.key,
    required this.height,
    required this.width,
    required this.image,
    required this.imageError,
    required this.colorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: colorBackground, borderRadius: BorderRadius.circular(50)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: image,
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (ctx, v) =>
              const CircularProgressIndicator(color: Palette.mainColor),
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imageError,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
