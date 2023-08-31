import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/meduls/common/bloc/notification_cubit/notification_cubit.dart';
import 'package:hatlli/meduls/common/models/notification_model.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/order_details_screen.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/texts.dart';

class DetailsNotificationScreen extends StatefulWidget {
  final NotificationModel notificationModel;
  const DetailsNotificationScreen({super.key, required this.notificationModel});

  @override
  State<DetailsNotificationScreen> createState() =>
      _DetailsNotificationScreenState();
}

class _DetailsNotificationScreenState extends State<DetailsNotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationCubit.get(context)
        .viewAlert(widget.notificationModel.id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xffFEFEFE),
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Texts(
                title: widget.notificationModel.title!,
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "طلب رقم  :  # ${widget.notificationModel.pageId}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: AppFonts.caB,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  Text(
                    widget.notificationModel.description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: AppFonts.caB,
                        fontSize: 18,
                        color: Palette.mainColor),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        title: "المزيد",
                        onPressed: () {
                          
                          pushPage(
                              context,
                              OrderDetailsScreen(
                                  id: widget.notificationModel.pageId!));
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
