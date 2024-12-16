import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  DateTime? expDate;
  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.verticalSpace,
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      25.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Card Holder",
                              style: GoogleFonts.josefinSans(
                                fontSize: 17.sp,
                                color: Color(0xff2C303E),
                              ),
                            )
                          ],
                        ),
                      ),
                      5.verticalSpace,
                      Fields(controller: cardHolderController),
                      20.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Card Number",
                              style: GoogleFonts.josefinSans(
                                fontSize: 17.sp,
                                color: Color(0xff2C303E),
                              ),
                            )
                          ],
                        ),
                      ),
                      5.verticalSpace,
                      CardNumberField(controller: cardNumberController),
                      25.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Exp Date",
                                      style: GoogleFonts.josefinSans(
                                        fontSize: 17.sp,
                                        color: Color(0xff2C303E),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              5.verticalSpace,
                              ExpDateField(controller: expDateController),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "CVV",
                                      style: GoogleFonts.josefinSans(
                                        fontSize: 17.sp,
                                        color: Color(0xff2C303E),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              5.verticalSpace,
                              FieldsSmall(controller: cvvController),
                            ],
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          if (cardHolderController.text.isEmpty) {
                            Get.snackbar(
                                'Required', 'Please fill card holder name.');
                          } else if (cardNumberController.text.isEmpty) {
                            Get.snackbar(
                                'Required', 'Please fill card number.');
                          } else if (expDateController.text.isEmpty) {
                            Get.snackbar(
                                'Required', 'Please fill card expire date.');
                          } else if (cvvController.text.isEmpty) {
                            Get.snackbar(
                                'Required', 'Please fill card CVV number.');
                          } else if (!RegExp(
                                  r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$")
                              .hasMatch(expDateController.text)) {
                            Get.snackbar('Error', 'Invalid expiry date');
                          } else if ((int.tryParse(expDateController.text
                                          .split("/")
                                          .last) ??
                                      0) <
                                  DateTime.now().year &&
                              (int.tryParse(expDateController.text
                                          .split("/")
                                          .first) ??
                                      0) <
                                  DateTime.now().month) {
                            Get.snackbar('Error', 'Invalid expiry date');
                          } else {
                            Get.back(
                              result: {
                                'cardDetails': CardDetails(
                                    number: cardNumberController.text,
                                    expirationMonth: int.tryParse(
                                        expDateController.text
                                            .split('/')
                                            .first),
                                    expirationYear: int.tryParse(
                                        expDateController.text.split('/').last),
                                    cvc: cvvController.text),
                                'cardHolderName': cardHolderController.text
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 290.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xffEA8806),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Now",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Fields({required TextEditingController controller}) {
    return Container(
      width: 398.w,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            bottom: 0.r,
            top: 20.r,
            left: 20.r,
          ),
          // hintText: txt,
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 17.sp,
              fontFamily: "Ragular"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Color(0xffFFE74D),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  FieldsSmall({required TextEditingController controller}) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 3,
        controller: controller,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            bottom: 0.r,
            top: 20.r,
            left: 20.r,
          ),
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 17.sp,
              fontFamily: "Ragular"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Color(0xffFFE74D),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ExpDateField({required TextEditingController controller}) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: TextFormField(
        validator: (value) {
          if (!RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$")
              .hasMatch(value ?? '')) {
            return 'Invalid';
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20),
        inputFormatters: [
          MaskedTextInputFormatter(mask: 'xx/xx', separator: '/')
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            bottom: 0.r,
            top: 20.r,
            left: 20.r,
          ),
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 17.sp,
              fontFamily: "Ragular"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Color(0xffFFE74D),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

CardNumberField({required TextEditingController controller}) {
  return Container(
    width: 398.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        MaskedTextInputFormatter(mask: 'xxxx-xxxx-xxxx-xxxx', separator: '-')
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          bottom: 0.r,
          top: 20.r,
          left: 20.r,
        ),
        // hintText: txt,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 17.sp,
            fontFamily: "Ragular"),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            width: 1.w,
            color: Color(0xffFFE74D),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  }) {}

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
