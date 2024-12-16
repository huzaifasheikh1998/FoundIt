import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/ViewModel/add_card_detail_view_model.dart';
import 'package:foundit/resources/components/customOutlineButton.dart';
import 'package:foundit/resources/components/textFieldDesign1.dart';
import 'package:get/get.dart';

class AddCardDetail extends StatelessWidget {
  AddCardDetail({super.key});

  AddCardDetailViewModel addCardDetailViewModel =
      Get.put(AddCardDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF1F2F6),
        appBar: AppBar(
          leadingWidth: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Card Details",
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff2C2C2C)),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
          child: Container(
              height: 0.9.sh,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                30.verticalSpace,
                TextFieldDesign1(
                  controller: addCardDetailViewModel.cardHolderController,
                  label: "Card Holder",
                ),
                TextFieldDesign1(
                  controller: addCardDetailViewModel.cardNoController,
                  label: "Card Number",
                  inputType: TextInputType.number,
                  inputFormat: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldDesign1(
                      readOnly: true,
                      width: 180,
                      controller: addCardDetailViewModel.expiryDateController,
                      label: "Expiry Date",
                      onTap: () {
                        addCardDetailViewModel.selectExpiryDate(context);
                      },
                    ),
                    TextFieldDesign1(
                      width: 180,
                      maxLength: 3,
                      controller: addCardDetailViewModel.cvcController,
                      label: "CVC",
                      inputType: TextInputType.number,
                      inputFormat: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
                50.verticalSpace,
                CustomOutlineButton(
                    title: 'Add Card',
                    onTap: () {
                      addCardDetailViewModel.validate(context);
                    })
              ])),
        ));
  }
}
