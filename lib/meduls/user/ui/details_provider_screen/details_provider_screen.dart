import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/bloc/favoraite_cubit/favoraite_cubit.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../components/app_bar_widget.dart';
import 'components/details_provider_widget.dart';

import 'components/store_provider_widget.dart';

class DetailsProviderScreen extends StatefulWidget {
  final int providerId;
  const DetailsProviderScreen({super.key, required this.providerId});

  @override
  State<DetailsProviderScreen> createState() => _DetailsProviderScreenState();
}

class _DetailsProviderScreenState extends State<DetailsProviderScreen> {
  @override
  void initState() {
    super.initState();
    ProviderCubit.get(context)
        .getProviderDetails(providerId: widget.providerId);
    CartCubit.get(context).getCarts(isState: false);
    FavoriteCubit.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProviderCubit, ProviderState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                //** app bar */
                AppBarWidget(
                  loading: GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  title: "تفاصيل المزود",
                ),
                const SizedBox(
                  height: 28,
                ),
//** =========== */
//** tab Widget  */
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabContainerProvider(
                      title: "المتجر",
                      textColor: state.indexDetailsProvider == 0
                          ? Palette.white
                          : const Color(0xffBBBBBB),
                      backgroundColor: state.indexDetailsProvider == 0
                          ? Palette.mainColor
                          : Colors.white,
                      onTap: () {
                        ProviderCubit.get(context)
                            .changeCurrentIndexDetailsProvider(0);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TabContainerProvider(
                      title: "بيانات المزود",
                      textColor: state.indexDetailsProvider == 1
                          ? Palette.white
                          : const Color(0xffBBBBBB),
                      backgroundColor: state.indexDetailsProvider == 1
                          ? Palette.mainColor
                          : Colors.white,
                      onTap: () {
                        ProviderCubit.get(context)
                            .changeCurrentIndexDetailsProvider(1);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Expanded(
                  child: state.getDetailsProviderState == RequestState.loaded
                      ? IndexedStack(
                          index: state.indexDetailsProvider,
                          children: [
                            StoreProviderWidget(
                                providerDetails:
                                    state.detailsProviderResponse!),
                            DetailsProverWidget(
                                providerDetails: state.detailsProviderResponse!)
                          ],
                        )
                      : const Center(
                          child: CustomCircularProgress(
                            fullScreen: false,
                            strokeWidth: 4,
                            size: Size(50, 50),
                          ),
                        ),
                )
                //** =========== */
              ],
            ),
          );
        },
      ),
    );
  }
}

class TabContainerProvider extends StatelessWidget {
  final String title;
  final Color textColor, backgroundColor;
  final void Function() onTap;
  final double width;
  const TabContainerProvider(
      {super.key,
      required this.title,
      required this.textColor,
      required this.backgroundColor,
      required this.onTap,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(width: .8, color: textColor),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Texts(
          title: title,
          family: AppFonts.taM,
          size: 12,
          textColor: textColor,
        )),
      ),
    );
  }
}
