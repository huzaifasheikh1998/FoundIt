import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foundit/Model/user_model.dart';
import 'package:foundit/Utils/app_assets.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/order_history_view_model.dart';
import 'package:get/get.dart';

class HistoryTile extends StatelessWidget {
  final String size;
  final String address;
  final String quantity;
  final String status;
  final String amount;
  final String orderId;

  const HistoryTile(
      {super.key,
      required this.size,
      required this.address,
      required this.quantity,
      required this.amount,
      required this.status,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(OrderHistoryViewModel());

    return GetBuilder<OrderHistoryViewModel>(
      init: _controller,
      builder: (controller) => Container(
        // height: 220.h,
        // margin: EdgeInsets.only(bottom: 60.h),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              // height: 185.h,
              width: 0.9.sw,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.55.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Content(
                                  data: "Size",
                                  size: 15.sp,
                                  color: AppColor.black,
                                  weight: FontWeight.bold,
                                ),
                                Content(
                                  data: size,
                                  size: 15.sp,
                                  color: AppColor.labelColor,
                                ),
                              ],
                            ),
                            20.h.verticalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Content(
                                  data: "Address",
                                  size: 15.sp,
                                  color: AppColor.black,
                                  weight: FontWeight.bold,
                                ),
                                Content(
                                  data: address,
                                  size: 15.sp,
                                  color: AppColor.labelColor,
                                  maxLines: 3,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _controller.selected == 1
                              ? Content(
                                  data: status.capitalize.toString(),
                                  size: 14.sp,
                                  color: Color(0xff667080).withOpacity(.6),
                                  weight: FontWeight.bold,
                                )
                              : SizedBox.shrink(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Content(
                                data: "Quantity",
                                size: 15.sp,
                                color: AppColor.black,
                                weight: FontWeight.bold,
                              ),
                              Content(
                                data: quantity,
                                size: 15.sp,
                                color: AppColor.labelColor,
                              ),
                            ],
                          ),
                          20.h.verticalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Content(
                                data: "Amount",
                                size: 15.sp,
                                color: AppColor.labelColor,
                              ),
                              Content(
                                data: "\$$amount",
                                size: 20.sp,
                                color: AppColor.orange,
                                weight: FontWeight.bold,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  20.h.verticalSpace,
                  _controller.selected == 2
                      ? SizedBox.shrink()
                      : (_controller.selected == 1 && status == "pending") ||
                              _controller.selected == 3
                          ? GestureDetector(
                              onTap: () {
                                _controller.reasonController.clear();
                                _controller.images.clear();
                                _controller.selected == 3
                                    ? Utils.refundOrderDialogBox(
                                        uploadMedia: () {
                                          _controller.pickImages();
                                        },
                                        context: context,
                                        submit: () async {
                                          Map<String, dynamic> data = {
                                            "user_id": User.data.userId,
                                            "order_id": orderId,
                                            "cancel_reason": _controller
                                                .reasonController.text
                                                .toString(),
                                            "status": "refund",
                                            "type": "refund",
                                          };
                                          if (_controller
                                              .reasonController.text.isEmpty) {
                                            Utils.showSnackBar(
                                                type: false,
                                                msg: "Please type your reason");
                                          } else if (_controller
                                              .images.isEmpty) {
                                            Utils.showSnackBar(
                                                type: false,
                                                msg: "Please upload media");
                                          } else {
                                            await _controller
                                                .fetchRefundOrderResponse(data,
                                                    context, _controller.images)
                                                .whenComplete(() {
                                              _controller
                                                  .fetchOrderHistoryResponse();
                                              _controller.reasonController
                                                  .clear();
                                            });
                                          }
                                        },
                                        reasonController:
                                            _controller.reasonController,
                                        selected: _controller.selected)
                                    : Utils.cancelOrderDialogBox(
                                        context: context,
                                        submit: () async {
                                          Map<String, dynamic> data = {
                                            "user_id": User.data.userId,
                                            "order_id": orderId,
                                            "cancel_reason": _controller
                                                .reasonController.text
                                                .toString(),
                                            "status": "cancel",
                                            "type": "cancel",
                                          };
                                          if (_controller.reasonController.text
                                              .isNotEmpty) {
                                            await _controller
                                                .fetchCancelOrderResponse(
                                                    data, context)
                                                .whenComplete(() {
                                              _controller
                                                  .fetchOrderHistoryResponse();
                                              _controller.reasonController
                                                  .clear();
                                            });
                                          } else {
                                            Utils.showSnackBar(
                                                type: false,
                                                msg: "Please type your reason");
                                          }
                                        },
                                        reasonController:
                                            _controller.reasonController,
                                        selected: _controller.selected);
                              },
                              child: Container(
                                width: Get.width,
                                height: Get.height * 0.056,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xffF09722),
                                      Color(0xffF5A235),
                                      Color(0xffF5A235),
                                      Color(0xff0EA8806),
                                      // Color(0xff784C11),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffF5A235),
                                      blurRadius: 5.r,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _controller.selected == 3
                                        ? "Refund"
                                        : "Cancel Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink()
                ],
              ),
            ),
            Positioned(
              top: -45.h,
              child: Container(
                  height: 110.h,
                  width: 0.9.sw,
                  padding: EdgeInsets.all(25.r),
                  decoration: BoxDecoration(
                      color: AppColor.white, shape: BoxShape.circle),
                  child: SvgPicture.asset(AppAsset.qr)),
            ),
          ],
        ),
      ),
    );
  }
}
