import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/View/Home/OrderPayment.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatelessWidget {
  String? cardNumber;
  String? cardHolderName;
  String? expMonth;
  String? expYear;
  CardWidget({
    super.key,
    this.cardNumber,
    this.cardHolderName,
    this.expMonth,
    this.expYear,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xff2E3240),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CARD NUMBER', style: getTextStyle(fontSize: 24)),
                    Row(
                      children: [
                        Text('**** **** ****',
                            style: getTextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                        Text(
                            cardNumber != null
                                ? cardNumber!.substring(cardNumber!.length - 4)
                                : '****',
                            style: getTextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 55.h,
                  child: Image.asset(cardNumber != null
                      ? cardNumber!.startsWith('4')
                          ? 'assets/images/visa_logo.png'
                          : 'assets/images/mastercard_logo.png'
                      : 'assets/images/mastercard_logo.png'),
                ),
              )
            ],
          ),
          SizedBox(
            height: 45.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CARD HOLDER', style: getTextStyle(fontSize: 18)),
                    Text(cardHolderName != null ? cardHolderName! : '******',
                        style: getTextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EXP DATE', style: getTextStyle(fontSize: 16)),
                    Text(expMonth != null ? '$expMonth/$expYear' : "--/--",
                        style: getTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle getTextStyle({required double fontSize, FontWeight? fontWeight}) {
  return GoogleFonts.openSans(
    color: Colors.white,
    fontSize: fontSize.sp,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}
