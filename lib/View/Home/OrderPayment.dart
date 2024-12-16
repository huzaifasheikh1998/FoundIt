import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Model/order_data.dart';
import 'package:foundit/View/Home/AddCardDetail.dart';
import 'package:foundit/ViewModel/order_payment_view_model.dart';
import 'package:foundit/resources/components/card_widget.dart';
import 'package:foundit/resources/components/customOutlineButton.dart';
import 'package:foundit/resources/components/paymentDetailTile.dart';
import 'package:get/get.dart';

class OrderPaymentScreen extends StatelessWidget {
  final OrderData orderData;
  OrderPaymentScreen({super.key, required this.orderData});
  OrderPaymentViewModel orderPaymentViewModel =
      Get.put(OrderPaymentViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Payment",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 56.w,
              height: 38.h,
              child: Image.asset("assets/images/Group 331@2x.png"),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,
                    GetBuilder(
                        init: orderPaymentViewModel,
                        builder: (value) {
                          return GestureDetector(
                            onTap: () async {
                              var t =
                                  value.cardDetail?['card_holder_name'] ?? null;
                              log(t.toString());
                              Map<String, dynamic> addCardReturnData =
                                  await Get.to(() => AddCardDetail(),
                                      transition: Transition.circularReveal,
                                      duration: Duration(milliseconds: 500));
                              if (addCardReturnData != null) {
                                value.setCardDetail(addCardReturnData);
                              }
                            },
                            // child: Container(
                            //   height: 100,
                            //   width: 100,
                            //   color: Colors.amber,
                            // ),
                            child: CardWidget(
                                cardHolderName:
                                    value.cardDetail?['card_holder_name'] ??
                                        null,
                                cardNumber: value.cardDetail?['number'] ?? null,
                                expMonth:
                                    value.cardDetail?['exp_month'] ?? null,
                                expYear: value.cardDetail?['exp_year'] ?? null),
                          );
                        }),
                    48.55.verticalSpace,
                    Column(
                      children: [
                        PaymentDetailTile(
                            title: "Size", content: orderData.size),
                        20.verticalSpace,
                        PaymentDetailTile(
                            title: 'Quantity',
                            content: orderData.qty.toString()),
                        20.verticalSpace,
                        PaymentDetailTile(
                            title: "Price", content: "\$${orderData.price}"),
                        20.verticalSpace,
                        PaymentDetailTile(
                            title: "Shipping",
                            content: "\$${orderData.shipping}"),
                        20.verticalSpace,
                        PaymentDetailTile(
                            title: 'Tax', content: '\$${orderData.tax}'),
                        20.verticalSpace,
                        PaymentDetailTile(
                            title: 'Total', content: '\$${orderData.total}'),
                        40.verticalSpace,
                        GetBuilder(
                            init: orderPaymentViewModel,
                            builder: (value) {
                              return CustomOutlineButton(
                                  loading: value.orderPaymentResponse.status ==
                                      Status.LOADING,
                                  title: 'Confirm',
                                  onTap: () {
                                    value.checkValidation(context, orderData);
                                    // resultAlert(
                                    //     result: true,
                                    //     title: "Congratulation",
                                    //     msg: "Payment done successfully",
                                    //     context: context);
                                  });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
