import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/animations/slide_transtion.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/app_radius.dart';
import 'package:hatlli/core/layout/app_sizes.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/ui/pdf_prview_page.dart';
import 'package:hatlli/meduls/provider/bloc/statist_cubit/statist_cubit.dart';
import 'package:hatlli/meduls/provider/ui/total_orders_screen/total_orders_screen.dart';
import 'package:hatlli/meduls/user/ui/details_provider_screen/details_provider_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/layout/palette.dart';
import '../../../user/ui/components/darwer_widget.dart';
import '../home_screen/home_screen.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    Future.delayed(Duration.zero, () {
      StatistCubit.get(context).initDates(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffolded,
        backgroundColor: const Color(0xffFEFEFE),
        drawer: const DrawerWidget(),
        appBar: appBarWidget(
            scaffolded: scaffolded, title: "الاحصائيات".tr(), context: context),
        body: BlocBuilder<StatistCubit, StatistState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Texts(
                              title:
                                  "يمكنك الاطلاع على التقارير بشكل كامل".tr(),
                              family: AppFonts.taB,
                              size: 16),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      //*TapBar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabContainerProvider(
                            title: "اسبوعي".tr(),
                            width: 89,
                            textColor: state.typeStatistTime == 0
                                ? Colors.white
                                : Color(0xffBBBBBB),
                            backgroundColor: state.typeStatistTime == 0
                                ? Palette.mainColor
                                : Colors.transparent,
                            onTap: () {
                              StatistCubit.get(context)
                                  .changeTypeTimeStatist(0);
                              StatistCubit.get(context).changeEndDateStatist(
                                  state.startDateStatist!, 0);
                              StatistCubit.get(context).getReviewProvider(
                                  context: context,
                                  start: state.endDateStatist,
                                  type: 0);
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          TabContainerProvider(
                            title: "شهري".tr(),
                            width: 89,
                            textColor: state.typeStatistTime == 1
                                ? Colors.white
                                : Color(0xffBBBBBB),
                            backgroundColor: state.typeStatistTime == 1
                                ? Palette.mainColor
                                : Colors.transparent,
                            onTap: () {
                              StatistCubit.get(context)
                                  .changeTypeTimeStatist(1);
                              StatistCubit.get(context).changeEndDateStatist(
                                  state.startDateStatist!, 1);
                              StatistCubit.get(context).getReviewProvider(
                                  context: context,
                                  start: state.endDateStatist,
                                  type: 1);
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          TabContainerProvider(
                            title: "سنوي".tr(),
                            width: 89,
                            textColor: state.typeStatistTime == 2
                                ? Colors.white
                                : Color(0xffBBBBBB),
                            backgroundColor: state.typeStatistTime == 2
                                ? Palette.mainColor
                                : Colors.transparent,
                            onTap: () {
                              StatistCubit.get(context)
                                  .changeTypeTimeStatist(2);
                              StatistCubit.get(context).changeEndDateStatist(
                                  state.startDateStatist!, 2);
                              StatistCubit.get(context).getReviewProvider(
                                  context: context,
                                  start: state.endDateStatist,
                                  type: 2);
                            },
                          ),
                        ],
                      )

                      //** ===== */
                      ,
                      const SizedBox(
                        height: 20,
                      ),
                      //** date */
                      Row(
                        children: [
                          ContainerDate(
                            title: state.startDateStatist != null
                                ? " من تاريخ ".tr() + state.startDateStatist!
                                : "",
                            onTap: () {
                              showDateTimePicker2(context, onConfirm: (date) {
                                pop(context);
                                print(formatDate(date));
                                StatistCubit.get(context).changeEndDateStatist(
                                    formatDate(date), state.typeStatistTime);
                                StatistCubit.get(context).getReviewProvider(
                                    context: context,
                                    start: state.endDateStatist,
                                    type: state.typeStatistTime);
                              });
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ContainerDate(
                            title: state.endDateStatist != null
                                ? " إلي تاريخ ".tr() + state.endDateStatist!
                                : "",
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      state.getReviewsProviderState == RequestState.loaded
                          ? Column(
                              children: [
                                ContainerAccount(
                                  wallet: state.reviewModel != null
                                      ? state.reviewModel!.wallet
                                      : 0.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //       ** container
                                GestureDetector(
                                  onTap: () {
                                    pushTranslationPage(
                                        context: context,
                                        transtion: FadTransition(
                                            page: TotalOrdersScreen(
                                                providerId: state.reviewModel!
                                                    .provider.id)));
                                  },
                                  child: ContainerOrdersStatis(
                                    percent:
                                        (state.reviewModel!.ordersAccepted *
                                                100) /
                                            state.reviewModel!.ordersCanceled,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //** best cities */
                                GestureDetector(
                                    onTap: () {
                                      if (state.reviewModel!.most.id != 0) {
                                        openGoogleMapLocation(
                                            lat: state.reviewModel!.most.lat,
                                            lng: state.reviewModel!.most.lng);
                                      }
                                    },
                                    child: BestCitiesWidget(
                                      precent:  (state.reviewModel!.most.id *
                                                100) /
                                            (state.reviewModel!.ordersAccepted + state.reviewModel!.ordersCanceled),
                                        city:
                                            state.reviewModel!.most.description,
                                        countOrders:
                                            state.reviewModel!.most.id)),

                                const SizedBox(
                                  height: 31,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // ** draw pdf
                                    pushPage(
                                        context,
                                        PdfPreviewPage(
                                          startDat: state.startDateStatist!,
                                          reviewModel: state.reviewModel!,
                                          endDate: state.endDateStatist!,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Texts(
                                          title: "التقرير الاسبوعي".tr(),
                                          family: AppFonts.taB,
                                          size: 16),
                                      SvgPicture.asset("assets/icons/print.svg")
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //** charts */
                                Container(
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),

                                        // Chart title

                                        // Enable legend
                                        // legend: Legend(isVisible: true),
                                        // Enable tooltip
                                        tooltipBehavior: _tooltipBehavior,
                                        series: <ChartSeries<SalesData,
                                            String>>[
                                      // Renders column chart
                                      ColumnSeries<SalesData, String>(
                                          color: Palette.mainColor,
                                          trackBorderWidth: AppSize.s20,
                                          width: .20,
                                          dataSource:
                                              StatistCubit.get(context).data,
                                          xValueMapper: (SalesData data, _) =>
                                              data.name.tr(),
                                          yValueMapper: (SalesData data, _) =>
                                              data.value)
                                    ])),
                              ],
                            )
                          : CustomCircularProgress()
                    ]),
              ),
            );
          },
        ));
  }
}

class BestCitiesWidget extends StatelessWidget {
  final double precent;
  final String city;
  final int countOrders;
  const BestCitiesWidget({
    super.key,
    required this.precent,
    required this.city,
    required this.countOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1.0, color: const Color(0xfff2f2f2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(children: [
        ContainerRadio(
          color: Color(0xffA80AD8),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts(
              title: "أكثر المناطق طلباً".tr(),
              family: AppFonts.taB,
              size: 14,
              height: .5,
            ),
            SizedBox(
              height: city == "" ? 0 : 3,
            ),
            city == ""
                ? SizedBox()
                : SizedBox(
                    width: 150,
                    child: Expanded(
                        child: Texts(
                            line: 2,
                            title: city,
                            family: AppFonts.taM,
                            textColor: Colors.grey,
                            size: 12))),
          ],
        ),
        SizedBox(
          width: 18,
        ),
        Texts(
            title: countOrders.toString() + " " + "طلبا".tr(),
            family: AppFonts.taB,
            size: 14),
        Spacer(),
        PercentWidget(
          color: Color(0xffA80AD8),
          value:precent.isNaN ? 0.0 : precent,
        )
      ]),
    );
  }
}

class ContainerOrdersStatis extends StatelessWidget {
  final double percent;
  const ContainerOrdersStatis({
    super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1.0, color: const Color(0xfff2f2f2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(children: [
        const ContainerRadio(
          color: Color(0xffED7B62),
        ),
        const SizedBox(
          width: 8,
        ),
        Texts(title: "اجمالي الطلبات".tr(), family: AppFonts.taB, size: 14),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffED7B62)),
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffF2EDED)),
            )
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Texts(
              title: "الطلبات المقبولة".tr(),
              family: AppFonts.taM,
              size: 10,
              height: .8,
            ),
            SizedBox(
              height: 9,
            ),
            Texts(
              title: "الطلبات الملغية".tr(),
              family: AppFonts.taM,
              size: 10,
              height: .8,
            ),
          ],
        ),
        Spacer(),
        PercentWidget(
          color: Color(0xffED7B62),
          value: percent.isNaN ? 0.0 : percent,
        )
      ]),
    );
  }
}

class PercentWidget extends StatelessWidget {
  final Color color;
  final double value;
  const PercentWidget({
    super.key,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 26.0,
      lineWidth: 7.0,
      percent: value / 100,
      center: Center(
          child: Texts(
        title: "${value.toStringAsFixed(0)} %",
        family: AppFonts.taB,
        textColor: color,
        size: 14,
        height: .2,
      )),
      backgroundColor: Colors.grey,
      progressColor: color,
    );
  }
}

class ContainerAccount extends StatelessWidget {
  final double wallet;
  const ContainerAccount({
    super.key,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1.0, color: const Color(0xfff2f2f2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(children: [
        Row(
          children: [
            ContainerRadio(
              color: Palette.mainColor,
            ),
            SizedBox(
              width: 5,
            ),
            Texts(title: "رصيدك الحالي".tr(), family: AppFonts.taB, size: 12)
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Texts(title: "$wallet SAR", family: AppFonts.taB, size: 16),
            GestureDetector(
              onTap: () {
                if (wallet > 0) {
                  showEnterWallet(context, blanca: wallet);
                }
              },
              child: Texts(
                  title: "سحب الرصيد".tr(),
                  family: AppFonts.taB,
                  textColor: wallet > 0 ? Palette.mainColor : Colors.grey,
                  size: 12),
            )
          ],
        )
      ]),
    );
  }

  void showEnterWallet(context, {blanca, start, type}) {
    final _controllerWalet = TextEditingController();
    showBottomSheetWidget(
      context,
      BlocBuilder<StatistCubit, StatistState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  padding: const EdgeInsets.only(top: 32, left: 18, right: 18),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Texts(
                              title: "سحب الرصيد".tr(),
                              family: AppFonts.taB,
                              size: 16,
                              textColor: Colors.black,
                              widget: FontWeight.normal),
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x0d000000),
                              offset: Offset(0, 0),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: _controllerWalet,
                          enabled: state.isAllMony ? false : true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "حدد قيمة السحب".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: AppFonts.taB)),
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      //** SWICH */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Texts(
                                  title: " سحب الرصيد بالكامل".tr(),
                                  family: AppFonts.caB,
                                  size: 14,
                                  textColor: Color(0xff4A4A4A),
                                  widget: FontWeight.normal),
                              Texts(
                                  title: "$blanca SAR",
                                  family: AppFonts.caB,
                                  size: 14,
                                  textColor: Color(0xff4A4A4A),
                                  widget: FontWeight.normal),
                            ],
                          ),
                          Transform.scale(
                            scaleX: .65,
                            scaleY: .65,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoSwitch(
                                activeColor: const Color(0xff22A45D),
                                thumbColor: Colors.white,
                                trackColor:
                                    const Color.fromARGB(255, 148, 150, 149),
                                onChanged: (value) {
                                  value = !state.isAllMony;
                                  StatistCubit.get(context)
                                      .changeTypeBlanca(value);
                                },
                                value: state.isAllMony,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      SizedBox(
                        width: 300,
                        height: AppSize.s50,
                        child: state.balanceWithdrawal == RequestState.loading
                            ? CustomCircularProgress(
                                strokeWidth: 3,
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (!state.isAllMony &&
                                      _controllerWalet.text.isEmpty) {
                                    showTopMessage(
                                        context: context,
                                        customBar: CustomSnackBar.error(
                                            backgroundColor: Colors.red,
                                            message: "حدد قيمة السحب".tr(),
                                            textStyle: TextStyle(
                                                fontFamily: "font",
                                                fontSize: 16,
                                                color: Colors.white)));
                                  } else if (!state.isAllMony &&
                                      double.parse(_controllerWalet.text) >
                                          wallet) {
                                    showTopMessage(
                                        context: context,
                                        customBar: CustomSnackBar.error(
                                            backgroundColor: Colors.red,
                                            message:
                                                "لا يوجد لديك رصيد كافي".tr(),
                                            textStyle: TextStyle(
                                                fontFamily: "font",
                                                fontSize: 16,
                                                color: Colors.white)));
                                  } else {
                                    print(_controllerWalet.text);
                                    StatistCubit.get(context)
                                        .balanceWithdrawal(
                                            context: context,
                                            mony: state.isAllMony
                                                ? "0.0"
                                                : _controllerWalet.text,
                                            start: state.endDateStatist,
                                            typeView: state.typeStatistTime,
                                            type: state.isAllMony ? 1 : 0)
                                        .then((value) {
                                      _controllerWalet.clear();
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                    Colors.black,
                                  ),
                                  elevation: MaterialStateProperty.all(10),
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (!states
                                        .contains(MaterialState.pressed)) {
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
                                child: Text(
                                  "تأكيد السحب".tr(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppFonts.taB,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}

class ContainerRadio extends StatelessWidget {
  final Color color;
  const ContainerRadio({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 16,
      width: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(width: 1, color: color)),
      child: Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class ContainerDate extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const ContainerDate({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 31,
        decoration: BoxDecoration(
            color: const Color(0xfBBBBBB),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Texts(
                title: title,
                family: AppFonts.taM,
                size: 12,
                height: .8,
              ),
              const SizedBox(
                width: 6,
              ),
              SvgPicture.asset("assets/icons/date.svg")
            ],
          ),
        ),
      ),
    ));
  }
}

class SalesData {
  final String name;
  final int value;

  SalesData(this.name, this.value);
}
