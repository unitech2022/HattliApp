import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/icon_alert_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/bloc/order_cubit/order_cubit.dart';


class PaymentScreen extends StatelessWidget {

  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: const Texts(
                title: "اختر عملية الدفع",
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
            actions: [
               IconAlertWidget(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                //** payment mthods */
                ContainerRadioButton(
                  title: "بطاقة ائتمان",
                  borderColor: const Color(0xffABABB7),
                  image: "assets/icons/pay1.svg",
                  color: Colors.transparent,
                  onTap: () {},
                ),
                ContainerRadioButton(
                  borderColor: const Color(0xffABABB7),
                  title: "باي بال",
                  image: "assets/icons/paypal.svg",
                  color: Colors.transparent,
                  onTap: () {},
                ),
                ContainerRadioButton(
                  borderColor: const Color(0xffABABB7),
                  title: "جوجل باي",
                  image: "assets/icons/google.svg",
                  color: Colors.transparent,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 65,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    title: "تأكيد الطلب",
                    onPressed: () {
                      OrderCubit.get(context).addOrder(0,context: context);
                    },
                    backgroundColor: Palette.mainColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContainerRadioButton extends StatelessWidget {
  final String image, title;
  final Color color, borderColor;
  final void Function() onTap;
  const ContainerRadioButton({
    super.key,
    required this.image,
    required this.title,
    required this.color,
    required this.onTap,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: .5,
                            color: const Color.fromARGB(255, 199, 198, 198))),
                    child: SvgPicture.asset(image)),
                const SizedBox(
                  width: 10,
                ),
                Texts(title: title, family: AppFonts.taB, size: 15)
              ],
            ),
            Container(
              padding: const EdgeInsets.all(2),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.5, color: borderColor)),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
