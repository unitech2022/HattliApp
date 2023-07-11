import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/bloc/notification_cubit/notification_cubit.dart';
import 'package:hatlli/meduls/common/models/notification_model.dart';
import 'package:hatlli/meduls/user/ui/notifications_screen/details_notification_screen.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/circular_progress.dart';

import '../../../../core/widgets/texts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationCubit.get(context).getAlerts(context: context);
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
              // leading: GestureDetector(
              //     onTap: () {
              //       scaffoldkey.currentState!.openDrawer();
              //     },
                
              //     child: Padding(
              //         padding: const EdgeInsets.all(15),
              //         child: SvgPicture.asset(
              //           "assets/icons/menu.svg",
              //           height: 17,
              //           width: 26,
              //         ))),
              title: const Texts(
                  title: "الاشعارات",
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
              // actions: [
              //  IconAlertWidget()
              // ],
            ),
            body: state.getAlertsState == RequestState.loaded
                ? state.alertResponse!.alerts.isEmpty
                    ? const EmptyListWidget(message: "لا توجد اشعارات ")
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 50, bottom: 40),
                        itemCount: state.alertResponse!.alerts.length,
                        itemBuilder: ((context, index) {
                          AlertResponse alertResponse = state.alertResponse!;
                          return GestureDetector(
                            onTap: () {
                              pushPage(
                                  context,
                                  DetailsNotificationScreen(
                                      notificationModel:
                                          alertResponse.alerts[index]));
                            },
                            child: Container(
                              height: 65,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
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
                              child: Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            alertResponse.alerts[index].viewed!
                                                ? Colors.grey
                                                : Palette.mainColor),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/alrm.svg"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts(
                                        title:
                                            alertResponse.alerts[index].title!,
                                        family: AppFonts.caR,
                                        size: 12,
                                        // textColor: const Color(0xffC3C3C3),
                                      ),
                                      Texts(
                                        title: alertResponse
                                            .alerts[index].description!,
                                        family: AppFonts.caR,
                                        size: 12,
                                        textColor: const Color(0xffC3C3C3),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Texts(
                                    title: alertResponse
                                        .alerts[index].createdAt!
                                        .split("T")[0],
                                    family: AppFonts.caR,
                                    size: 10,
                                    textColor: const Color(0xffC3C3C3),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
                : const Scaffold(
                    body: CustomCircularProgress(
                      fullScreen: true,
                      strokeWidth: 4,
                      size: Size(50, 50),
                    ),
                  ));
      },
    );
  }
}
