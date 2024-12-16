import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Utils/app_color.dart';

class CustomOutlineButton extends StatelessWidget {
  final bool loading;
  final String title;
  final String? icons;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color outlineColor;
  final Color fillColor;
  final Color textColor;
  const CustomOutlineButton({
    super.key,
    required this.title,
    this.icons,
    required this.onTap,
    this.loading = false,
    this.width = 380,
    this.height = 60,
    this.outlineColor = const Color(0xffFFFFFF),
    this.fillColor = AppColor.orange,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? () {} : onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33.r),
            // border: Border.all(width: 1.w, color: outlineColor),
            color: fillColor,
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffF5A336),
                Color(0xffF09722),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(01),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icons != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: Image.asset(
                            icons!,
                            scale: 3,
                            color: textColor,
                          ),
                        )
                      : SizedBox(),
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Roboto, Bold",
                        fontSize: 20.sp,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
