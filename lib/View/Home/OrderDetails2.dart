import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/resources/Custom%20CSC%20picker/csc_picker.dart';
import 'package:foundit/resources/components/customOutlineButton.dart';
import 'package:foundit/resources/components/textFieldDesign1.dart';
import 'package:get/get.dart';

class OrderDetails2Screen extends StatefulWidget {
  final OrderDetailViewModel orderDetailViewModel;
  OrderDetails2Screen({super.key, required this.orderDetailViewModel});

  @override
  State<OrderDetails2Screen> createState() => _OrderDetails2ScreenState();
}

class _OrderDetails2ScreenState extends State<OrderDetails2Screen> {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                50.verticalSpace,
                TextFieldDesign1(
                  controller: widget.orderDetailViewModel.addressController,
                  label: "Address",
                  hint: "Please enter Address",
                  suffixWidget: Icon(
                    Icons.location_searching,
                    color: AppColor.orange,
                  ),
                ),
                GetBuilder<OrderDetailViewModel>(
                    init: widget.orderDetailViewModel,
                    builder: (_value) {
                      return CSCPicker(
                        countryLabelWidget: Text(
                          "Country",
                          style: TextStyle(
                            color: AppColor.labelColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(left: 20.w, bottom: 5.h),
                        cityLabelWidget: Text(
                          "City",
                          style: TextStyle(
                            color: AppColor.labelColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(left: 20.w, bottom: 5.h),
                        stateLabelWidget: Text(
                          "State",
                          style: TextStyle(
                            color: AppColor.labelColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ).paddingOnly(left: 20.w, bottom: 5.h),
                        // disableCountry: true,
                        currentCountry: _value.countryController.text,
                        // currentState: _value.stateController.text,
                        // currentCity: _value.cityController.text,
                        layout: Layout.vertical,
                        showStates: true,
                        showCities: true,

                        flagState: CountryFlag.DISABLE,
                        dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33.r),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        disabledDropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33.r),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        countrySearchPlaceholder: "Country",
                        stateSearchPlaceholder: "State",
                        citySearchPlaceholder: "City",
                        countryDropdownLabel: "Country",
                        stateDropdownLabel: "State",
                        cityDropdownLabel: "City",
                        selectedItemStyle: TextStyle(
                          height: 3.5.h,
                          color: Colors.black,
                          fontSize: 18.0.sp,
                        ),
                        dropdownHeadingStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        dropdownItemStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dropdownDialogRadius: 26,
                        searchBarRadius: 10.0.r,
                        onCountryChanged: (value) {
                          if (value != null) {
                            _value.countryController.text = value;
                            _value.cityController.clear();
                            _value.stateController.clear();
                            setState(() {});
                            _value.update();
                            log("SELECTED COUNTRY: ${_value.countryController.text}");
                          }
                        },
                        onStateChanged: (value) {
                          if (value != null) {
                            _value.stateController.text = value;
                            _value.cityController;
                            _value.update();
                            setState(() {});
                            log("SELECTED state: ${_value.stateController.text}");
                          }
                        },
                        onCityChanged: (value) {
                          if (value != null) {
                            _value.cityController.text = value;
                            _value.update();
                            setState(() {});
                            log("SELECTED city: ${_value.cityController.text}");
                          }
                        },
                      );
                    }),
                8.verticalSpace,
                TextFieldDesign1(
                  controller: widget.orderDetailViewModel.zipCodeController,
                  label: "Zip Code",
                  hint: "Please enter Zip Code",
                ),
                TextFieldDesign1(
                  controller: widget.orderDetailViewModel.taxNumberController,
                  label: "Tax Number",
                  hint: "Please enter Tax Number",
                ),
                45.verticalSpace,
                GetBuilder<OrderDetailViewModel>(
                    init: widget.orderDetailViewModel,
                    builder: (value) {
                      return CustomOutlineButton(
                          title: 'Confirm',
                          loading:
                              value.trackOrderResponse.status == Status.LOADING,
                          onTap: () {
                            widget.orderDetailViewModel
                                .checkValidation2(context);
                          });
                    }),
                45.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
