import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Model/my_save_qr_data_model/save_qr_data.dart';
import 'package:foundit/Model/order_details_initial_param.dart';
import 'package:foundit/View/Alert/my_save_qr_alert.dart';
import 'package:foundit/View/Home/OrderDetails.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/main.dart';
import 'package:foundit/resources/components/customOutlineButton.dart';
import 'package:get/get.dart';

class SavedQrTile extends StatelessWidget {
  final SaveQrData data;
  const SavedQrTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mySaveQrAlert(data.qrCode.toString(), context);
      },
      child: Container(
        width: 390.w,
        height: 91.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 88.w,
                    height: 62.h,
                    decoration: BoxDecoration(
                        color: Color(0xffEA8833).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          30,
                        )),
                    child: Image.asset(
                      "assets/images/Icon awesome-qrcode@2x.png",
                      scale: 2,
                    ),
                  ),
                  20.horizontalSpace,
                  Text(
                    data.title.toString(),
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Container(
              //   width: 80.w,
              //   height: 62.h,
              //   child: Image.asset("assets/images/Group 391@2x.png"),
              // ),

              CustomOutlineButton(
                  width: 110,
                  height: 45,
                  title: 'Print',
                  onTap: () {
                    // final orderDetailViewModel =
                    //     Get.put(OrderDetailViewModel());

                    Get.off(() =>  (
                          orderDetailViewModel: orderDetailViewModel,
                          orderDetailsInitialParam: OrderDetailsInitialParam(
                              data.id.toString(), data.qrCode),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
