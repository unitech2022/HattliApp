import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/palette.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../provider/models/details_provider_response.dart';

class DetailsProverWidget extends StatelessWidget {
  final  DetailsProviderResponse providerDetails;
  const DetailsProverWidget({super.key, required this.providerDetails});

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
                        title: providerDetails.provider!.nameAdministratorCompany,
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
                            title:providerDetails.provider!.addressName.split(",")[0],
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
                     RatingBarWidget(rate: providerDetails.provider!.rate,),
                    Texts(
                        title: "يبعد عنك  ${providerDetails.provider!.discount} km",
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
            const Texts(
              title: "عن المزود",
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
          child:  Text(
           providerDetails.provider!.about,
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
        const Row(
          children: [
            Texts(
              title: "موقع المزود",
              family: AppFonts.taM,
              size: 14,
              textColor: Color(0xff4A4A4A),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Image.asset("assets/images/map.png")
      ]),
    );
  }
}
