import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/extension.dart';
import 'package:foundit/Utils/utils.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final String content;
  const NotificationTile(
      {super.key,
      required this.title,
      required this.time,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Content(
                data: title,
                weight: FontWeight.bold,
                color: Colors.black,
                size: 18.h,
                maxLines: 2,
              ),
            ),
            Content(
                data: Utils.timeStamp(time.toDate()),
                color: AppColor.labelColor,
                size: 18.h),
          ],
        ),
        5.verticalSpace,
        Content(data: content, size: 19.h, color: AppColor.labelColor)
      ],
    );
  }
}
