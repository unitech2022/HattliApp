import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/app_model.dart';

import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/models/cart_model.dart';
import 'package:moyasar/moyasar.dart';

class PaymentMethodsConfirmed extends StatefulWidget {
  final int total, type, productId, providerId,quntity;
 final String note;
  PaymentMethodsConfirmed(
      {super.key,
      required this.total,
      this.type = 0,
      required this.productId,
       required this.note,
      required this.providerId, required this.quntity});

  @override
  State<PaymentMethodsConfirmed> createState() =>
      _PaymentMethodsConfirmedState();
}

class _PaymentMethodsConfirmedState extends State<PaymentMethodsConfirmed> {
  PaymentConfig? paymentConfig;

  @override
  void initState() {
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_83UURo8Mjym2nc7jgxKhJLrVKrzgqNhogC5M4RoY',
      amount: widget.total, // SAR 257.58
      description: 'order ',
      metadata: {'size': '250g'},
      // applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'ليموزين'),
    );
  }

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          if (widget.type == 0) {
            OrderCubit.get(context).addOrder(1, context: context,nots:widget.note);
          } else {
            CartModel cartModel = CartModel(
                id: 0,
                userId: currentUser.id!,
                productId: widget.productId,
                providerId: widget.providerId,
                quantity: widget.quntity,
                status: 0,
                orderId: 0,
                cost: 0,
                createdAt: "createdAt");

            CartCubit.get(context).addCart(cartModel).then((value) {
              OrderCubit.get(context).addOrder(1, context: context,nots: "not");
            });
          }

          break;
        case PaymentStatus.failed:
          // handle failure.

          break;
        case PaymentStatus.initiated:
          // TODO: Handle this case.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: SvgPicture.asset(
                  "assets/icons/logo_black.svg",
                  width: 80,
                  height: 80,
                ),
              ),
              Texts(
                title: "هاتلي",
                textColor: Colors.black,
                size: 28,
                widget: FontWeight.bold,
                family: AppFonts.caB,
              ),
              SizedBox(
                height: 30,
              ),

              // ApplePay(
              //   config: paymentConfig,
              //   onPaymentResult: onPaymentResult,
              // ),
              // const Text("or"),
              CreditCard(
                config: paymentConfig!,
                onPaymentResult: onPaymentResult,
              )
            ],
          ),
        ),
      ),
    );
  }
}
