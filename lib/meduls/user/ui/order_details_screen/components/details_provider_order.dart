import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';

import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../common/models/order_response.dart';

class DetailsProviderOrder extends StatefulWidget {
  final OrderDetailsResponse response;
  const DetailsProviderOrder({
    super.key, required this.response,
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
          height: 75,
          padding: const EdgeInsets.all(5),
          child:  Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(
                      title:currentUser.role==AppModel.userRole?
                       widget.response.provider!.title:"رقم الطلب : ${widget.response.order!.id} #"
                       
                       ,
                       
                      family: AppFonts.taM,
                      size: 16,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
                  Texts(
                      title: "التاريخ :  ${widget.response.order!.createdAt.split("T")[0]}",
                      family: AppFonts.moM,
                      size: 12,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Texts(
                      title: " السعر :  ${widget.response.order!.productsCost.toString()}\$",
                      family: AppFonts.taB,
                      size: 16,
                      textColor: Colors.black,
                      widget: FontWeight.normal),
                  Row(
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
                          title: widget.response.provider!.addressName.split(",")[0],
                          family: AppFonts.taB,
                          size: 13,
                          textColor: Palette.mainColor,
                          widget: FontWeight.normal),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
