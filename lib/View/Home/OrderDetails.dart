import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Model/create_product_lov_data_model/variant.dart';
import 'package:foundit/Model/order_details_initial_param.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/resources/components/customOutlineButton.dart';
import 'package:foundit/resources/components/dropDownDesign1.dart';
import 'package:foundit/resources/components/textFieldDesign1.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailViewModel orderDetailViewModel;
  final OrderDetailsInitialParam orderDetailsInitialParam;
  OrderDetailsScreen(
      {super.key,
      required this.orderDetailViewModel,
      required this.orderDetailsInitialParam});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // void initState() {
  //   widget.orderDetailViewModel.setQrCode(widget.orderDetailsInitialParam);
  //   super.didChangeDependencies();
  // }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.orderDetailViewModel.fetchCreateProfileLovResponse();
    });
    widget.orderDetailViewModel.setQrCode(widget.orderDetailsInitialParam);
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.orderDetailViewModel.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey,
        appBar: AppBar(
          leadingWidth: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Content(
            data: "Order Details",
            size: 22.sp,
            weight: FontWeight.bold,
            color: Color(0xff2C2C2C),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              GetBuilder<OrderDetailViewModel>(
                  init: widget.orderDetailViewModel,
                  builder: (value) {
                    switch (value.createProductLovResponse.status) {
                      case Status.INIT:
                        return Container();
                      case Status.LOADING:
                        return Utils.showLoading(context);
                      case Status.ERROR:
                        return Utils.showError(
                            value.createProductLovResponse.message.toString());
                      case Status.COMPLETED:
                        return Column(
                          children: [
                            DropdownWigdet(
                              hintText: "Please select variant",
                              labelText: "Variant",
                              onChanged: (_value) {
                                value.setVariantValue(_value);
                                log(_value.runtimeType.toString());
                                log(_value.variantSize.toString());
                                log(_value.variantId.toString());
                              },
                              list: value
                                  .createProductLovResponse.data!.variants!
                                  .map((Variant? value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value!.variantSize.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                  ),
                                );
                              }).toList(),
                            ),
                            30.verticalSpace,
                            TextFieldDesign1(
                              controller: value.quantityController,
                              label: "Quantity",
                              hint: "Please enter Quantity",
                              inputType: TextInputType.number,
                              inputFormat: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            80.verticalSpace,
                            CustomOutlineButton(
                                title: 'Generate QR code',
                                onTap: () {
                                  widget.orderDetailViewModel
                                      .checkValidation1(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             OrderDetails2Screen()));
                                })
                          ],
                        );
                      default:
                        return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
