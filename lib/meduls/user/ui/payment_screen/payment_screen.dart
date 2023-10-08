import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/meduls/common/ui/payment/payment.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/icon_alert_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/bloc/order_cubit/order_cubit.dart';

class PaymentScreen extends StatelessWidget {
  final double total;
  final String note;
  const PaymentScreen({super.key, required this.total,required this.note});

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
            title: Texts(
                title: "اختر عملية الدفع".tr(),
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
                //** payment methods */
                ContainerRadioButton(
                  title: "الدفع كاش".tr(),
                  borderColor: state.payment == 0
                      ? Palette.mainColor
                      : const Color(0xffABABB7),
                  image: "assets/icons/cash.svg",
                  color: state.payment == 0
                      ? Palette.mainColor
                      : Colors.transparent,
                  onTap: () {
                    OrderCubit.get(context).changePayMentMethod(0);
                  },
                ),
                ContainerRadioButton(
                  borderColor: state.payment == 1
                      ? Palette.mainColor
                      : const Color(0xffABABB7),
                  title: "دفع أونلاين".tr(),
                  image: "assets/icons/pay1.svg",
                  color: state.payment == 1
                      ? Palette.mainColor
                      : Colors.transparent,
                  onTap: () {
                    OrderCubit.get(context).changePayMentMethod(1);
                  },
                ),
                // ContainerRadioButton(
                //   borderColor: const Color(0xffABABB7),
                //   title: "جوجل باي",
                //   image: "assets/icons/google.svg",
                //   color: Colors.transparent,
                //   onTap: () {},
                // ),

                const SizedBox(
                  height: 65,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    title: "تأكيد الطلب".tr(),
                    onPressed: () {
                      if (state.payment == 0) {
                        OrderCubit.get(context)
                            .addOrder(state.payment, context: context,nots: note);
                      } else {
                        // print(total);
                        pushPage(
                            context,
                            PaymentMethodsConfirmed(
                              note:note,
                              total: total.toInt() ,
                              productId: 0,
                              providerId: 0,
                              type: 0,
                              quntity: 0,
                            ));
                      }
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
