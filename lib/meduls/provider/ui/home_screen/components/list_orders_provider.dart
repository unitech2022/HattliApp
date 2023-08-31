import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/order_details_screen.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/palette.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../common/models/order.dart';

class ListOrdersProvider extends StatelessWidget {
  final List<OrderResponse> orders;
  const ListOrdersProvider({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          OrderResponse orderResponse = orders[index];
          return GestureDetector(
            onTap: () {
              pushPage(context,
                              OrderDetailsScreen(id: orderResponse.order.id));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29b6b6b6),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: orderResponse.imageUrl,
                          width: 26,
                          height: 26,
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/provider.png",
                            height: 26,
                            width: 26,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts(
                              title: orderResponse.name,
                              family: AppFonts.caR,
                              size: 12),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: .8,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icons/map2.svg"),
                          const SizedBox(
                            width: 5,
                          ),
                          Texts(
                            title: orderResponse.address.name  ??orderResponse.address.description!.split(",")[0],
                            family: AppFonts.moL,
                            size: 10,
                            textColor: Color(0xffA9A9AA),
                          )
                        ],
                      ),
                      Container(
                        width: 61,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Palette.mainColor),
                        child:  Center(
                            child: Texts(
                          title: "المزيد".tr(),
                          family: AppFonts.moL,
                          size: 10,
                          height: 2.0,
                          textColor: Colors.white,
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
