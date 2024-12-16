import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/ViewModel/order_history_view_model.dart';
import 'package:get/get.dart';

class HistoryTabBar extends StatelessWidget {
  final OrderHistoryViewModel controller;

  HistoryTabBar({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HistoryTab(
          value: 1,
          title: "Accepted",
          controller: controller,
        ),
        HistoryTab(
          value: 2,
          title: "Rejected",
          controller: controller,
        ),
        HistoryTab(
          value: 3,
          title: "Completed",
          controller: controller,
        ),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  final int value;

  final String title;
  final OrderHistoryViewModel controller;
  HistoryTab(
      {super.key,
      required this.value,
      required this.title,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.setSelected(value);
      },
      child: Container(
        width: 120.w,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: controller.selected == value
                ? AppColor.orange
                : AppColor.transparent,
            border: controller.selected != value
                ? Border.all(color: AppColor.orange, width: 1)
                : null,
            boxShadow: controller.selected == value
                ? [
                    BoxShadow(
                      color: Colors.orange.withOpacity(01),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    )
                  ]
                : []),
        child: Center(
          child: Content(
            data: title,
            size: 16.sp,
            color:
                controller.selected == value ? AppColor.white : AppColor.orange,
          ),
        ),
      ),
    );
  }
}
