import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';

class PaymentDetailTile extends StatelessWidget {
  final String title;
  final String content;
  const PaymentDetailTile(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 130.w,
            child: Content(
              data: title,
              size: 20.sp,
              color: AppColor.textGreyColor,
              googleFonts: true,
            )),
        Content(
            data: content,
            size: 20.sp,
            color: AppColor.textGreyColor,
            googleFonts: true)
      ],
    );
  }
}
