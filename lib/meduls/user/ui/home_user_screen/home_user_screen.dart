import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/layout/app_sizes.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/rating_bar_widget.dart';
import '../components/darwer_widget.dart';
import '../components/search_container_widget.dart';
import '../search_products_screen/search_products_screen.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(locData.latitude ?? 22, locData.longitude ?? 39),
    zoom: 14.4746,
  );

  List<Marker> list = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          drawer: const DrawerWidget(),
          body: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: _kGooglePlex,
                markers: Set<Marker>.of(state.markers),

                // markers: markers,
                // polylines: state.polyines,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    scaffoldkey.currentState!.openDrawer();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/menu.svg")),
                              const SizedBox(
                                width: 18,
                              ),
                              const Texts(
                                  title: "الرئيسية",
                                  family: AppFonts.taB,
                                  size: 18,
                                  widget: FontWeight.bold),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              pushPageRoutName(context, notyUser);
                            },
                            child: badges.Badge(
                              
                              badgeContent:  Text(
                                state.homeUserResponse!.notiyCount.toString(),
                                style:
                                    const TextStyle(color: Colors.white, height: 1.8),
                              ),
                              position: badges.BadgePosition.topStart(top: -12),
                              badgeStyle: const badges.BadgeStyle(badgeColor: Palette.mainColor),
                              
                              child: SvgPicture.asset("assets/icons/noty.svg"),
                            ),
                          )
                        ],
                      ),
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
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    var marker = Marker(
      onTap: () {
        showBottomSheetWidget(
            context,
            Container(
              padding: const EdgeInsets.only(top: 32, left: 18, right: 18),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Texts(
                      title: "تفاصيل المزود",
                      family: AppFonts.moM,
                      size: 14,
                      textColor: Color(0xff4A4A4A),
                      widget: FontWeight.normal),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
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
                            child: SvgPicture.asset(
                              "assets/icons/icon_logo.svg",
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Texts(
                                title: "اسم المزود",
                                family: AppFonts.moM,
                                size: 14,
                                textColor: Colors.black,
                                widget: FontWeight.normal),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/locationitem.svg"),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Texts(
                                    title: "الرياض",
                                    family: AppFonts.moM,
                                    size: 12,
                                    textColor: Color(0xff4A4A4A),
                                    widget: FontWeight.normal),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarWidget(
                              rate: 3.0,
                            ),
                            Texts(
                                title: "يبعد عنك    2.5km",
                                family: AppFonts.moM,
                                size: 12,
                                textColor: Color(0xff4A4A4A),
                                widget: FontWeight.normal),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  SizedBox(
                    width: context.wSize,
                    height: AppSize.s50,
                    child: ElevatedButton(
                      onPressed: () {
                        pop(context);
                        pushPageRoutName(context, detailsProvider);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                          Palette.mainColor,
                        ),
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.pressed)) {
                            return const RoundedRectangleBorder(
                              borderRadius: AppRadius.r10,
                              side: BorderSide.none,
                            );
                          }
                          return const RoundedRectangleBorder(
                            borderRadius: AppRadius.r10,
                          );
                        }),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "المزيد من التفاصيل",
                            style: context.titleM.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.moR,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                ],
              ),
            ));
      },
      markerId: const MarkerId('place_name'),
      position: const LatLng(37.43296265331129, -122.08832357078792),

      // icon: BitmapDescriptor.,
      // infoWindow: const InfoWindow(
      //   title: 'title',
      //   snippet: 'address',
      // ),
    );

    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
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
            child: Image.asset(imageError,fit: BoxFit.contain,),
          ),
        ),
      ),
    );
  }
}
