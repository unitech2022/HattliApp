import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';

import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/traking_order_screen/traking_order_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../common/models/order_response.dart';

class DetailsProviderOrder extends StatefulWidget {
  final OrderDetailsResponse response;
  const DetailsProviderOrder({
    super.key,
    required this.response,
  });

  @override
  State<DetailsProviderOrder> createState() => _DetailsProviderOrderState();
}

class _DetailsProviderOrderState extends State<DetailsProviderOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ProviderCubit.get(context)
    //     .getProviderDetails(providerId: widget.providerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderCubit, ProviderState>(
      builder: (context, state) {
        return Container(
          height: 80,
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(
                      title: currentUser.role == AppModel.userRole
                          ? widget.response.provider!.title
                          : "رقم الطلب".tr() +
                              " : " +
                              widget.response.order!.id.toString() +
                              "#",
                      family: AppFonts.taM,
                      size: 16,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
                  Texts(
                      title: "التاريخ".tr() +
                          " : " +formatDate2(DateTime.parse(widget.response.order!.createdAt)),
                        //  .split("T")[0] +" , "+ widget.response.order!.createdAt.split("T")[1],
                      family: AppFonts.moM,
                      size: 12,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Texts(
                          title: "طريقة الدفع : ".tr(),
                          family: AppFonts.taM,
                          size: 12,
                          textColor: Colors.black,
                          widget: FontWeight.normal),
                      Texts(
                          title: widget.response.order!.payment == 0
                              ? "كاش".tr()
                              : "مدفوع".tr(),
                          family: AppFonts.taB,
                          size: 16,
                          textColor: Colors.green,
                          widget: FontWeight.normal),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Texts(
                      title: "السعر".tr() +
                          " : " +
                          widget.response.order!.productsCost.toString() +
                          " SAR",
                      family: AppFonts.taB,
                      size: 16,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
          
                  GestureDetector(
                    onTap: () {
                      pushPage(
                          context,
                          TrackingOrderScreen(
                              lat: widget.response.address!.lat!,
                              lng: widget.response.address!.lng!));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Palette.mainColor,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Texts(
                            title: widget.response.provider!.addressName
                                .split(",")[0],
                            family: AppFonts.taB,
                            size: 13,
                            textColor: Palette.mainColor,
                            widget: FontWeight.normal),
                      ],
                    ),
                  )
               
                , currentUser.role==AppModel.providerRole?      GestureDetector(
                  onTap: () {
                     launchUrl(Uri.parse('tel:+${widget.response.userModel!.userName}'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Icon(Icons.call,color:Colors.green,size:15)
                            ,SizedBox(width:5)
                        ,Texts(title: "تواصل مع العميل".tr(),height: 1.2, family: AppFonts.taB, size: 14,textColor: Colors.green,),
                      
                      
                      ],
                    ),
                  ),
                ):SizedBox(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
