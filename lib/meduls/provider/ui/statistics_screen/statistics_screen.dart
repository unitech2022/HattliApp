import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/user/ui/details_provider_screen/details_provider_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffolded,
        backgroundColor: const Color(0xffFEFEFE),
        drawer: const DrawerWidget(),
        appBar: appBarWidget(scaffolded: scaffolded, title: "الاحصائيات",context: context),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Texts(
                          title: "يمكنك الاطلاع على التقارير بشكل كامل",
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
                        title: "اسبوعي",
                        width: 89,
                        textColor: Colors.white,
                        backgroundColor: Palette.mainColor,
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      TabContainerProvider(
                        title: "شهري",
                        width: 89,
                        textColor: Colors.white,
                        backgroundColor: Palette.mainColor,
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      TabContainerProvider(
                        title: "سنوي",
                        width: 89,
                        textColor: const Color(0xffBBBBBB),
                        backgroundColor: Colors.transparent,
                        onTap: () {},
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
                        title: "من تاريخ 21-8-2021",
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ContainerDate(
                        title: "من تاريخ 21-8-2021",
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const ContainerAccount(),
                  const SizedBox(
                    height: 10,
                  ),
//       ** container
                  const ContainerOrdersStatis(),
                  const SizedBox(
                    height: 10,
                  ),
                  //** best cities */
                  const BestCitiesWidget(),

                  const SizedBox(
                    height: 31,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Texts(
                          title: "التقرير الاسبوعي",
                          family: AppFonts.taB,
                          size: 16),
                      SvgPicture.asset("assets/icons/print.svg")
                    ],
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
                          series: <ChartSeries<SalesData, String>>[
                        // Renders column chart
                        ColumnSeries<SalesData, String>(
                          color: Palette.mainColor,
                          
                            dataSource: data,
                            xValueMapper: (SalesData data, _) => data.name,
                            yValueMapper: (SalesData data, _) => data.value)
                      ])),
                ]),
          ),
        ));
  }
}

List<SalesData> data = [
  SalesData('Jan', 35),
  SalesData('Feb', 28),
  SalesData('Mar', 34),
  SalesData('Apr', 32),
  SalesData('May', 40)
];

class BestCitiesWidget extends StatelessWidget {
  const BestCitiesWidget({
    super.key,
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
      child: const Row(children: [
        ContainerRadio(
          color: Color(0xffA80AD8),
        ),
        SizedBox(
          width: 10,
        ),
        Texts(
          title: "أكثر المناطق طلباً",
          family: AppFonts.taB,
          size: 14,
          height: .5,
        ),
        SizedBox(
          width: 20,
        ),
        Texts(title: "158  Order", family: AppFonts.taB, size: 14),
        SizedBox(
          width: 15,
        ),
        PercentWidget(
          color: Color(0xffA80AD8),
          value: "75%",
        )
      ]),
    );
  }
}

class ContainerOrdersStatis extends StatelessWidget {
  const ContainerOrdersStatis({
    super.key,
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
        const Texts(title: "اجمالي الطلبات", family: AppFonts.taB, size: 14),
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
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Texts(
              title: "الطلبات المقبولة",
              family: AppFonts.taM,
              size: 10,
              height: .8,
            ),
            SizedBox(
              height: 9,
            ),
            Texts(
              title: "الطلبات الملغية",
              family: AppFonts.taM,
              size: 10,
              height: .8,
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        const PercentWidget(
          color: Color(0xffED7B62),
          value: "75%",
        )
      ]),
    );
  }
}

class PercentWidget extends StatelessWidget {
  final Color color;
  final String value;
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
      percent: 0.8,
      center: Center(
          child: Texts(
        title: value,
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
  const ContainerAccount({
    super.key,
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
      child: const Column(children: [
        Row(
          children: [
            ContainerRadio(
              color: Palette.mainColor,
            ),
            SizedBox(
              width: 5,
            ),
            Texts(title: "رصيدك الحالي", family: AppFonts.taB, size: 12)
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Texts(title: "5000 SAR", family: AppFonts.taB, size: 16),
            Texts(
                title: "سحب الرصيد",
                family: AppFonts.taB,
                textColor: Palette.mainColor,
                size: 12)
          ],
        )
      ]),
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
