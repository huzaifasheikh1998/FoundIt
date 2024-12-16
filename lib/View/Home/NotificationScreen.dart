import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/notification_view_model.dart';
import 'package:foundit/resources/components/notification_tile.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationViewModel viewModel;
  const NotificationScreen({super.key, required this.viewModel});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Content(
          data: "Notification",
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
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            GetBuilder<NotificationViewModel>(
                init: widget.viewModel,
                builder: (value) {
                  switch (value.notificationResponse.status) {
                    case Status.INIT:
                      return Container();
                    case Status.LOADING:
                      return Utils.showLoading(context);
                    case Status.ERROR:
                      return Utils.showError(
                          value.notificationResponse.message.toString());
                    case Status.COMPLETED:
                      return Expanded(
                        child: Column(
                          children: [
                            25.verticalSpace,
                            value.notificationResponse.data?.data?.length == 0
                                ? Utils.showError("No Notification Found")
                                : Expanded(
                                    child: SizedBox(
                                      // height: 0.765.sh,
                                      child: ListView.separated(
                                        itemCount: value.notificationResponse
                                                .data?.data?.length ??
                                            0,
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final iteration = value
                                              .notificationResponse
                                              .data!
                                              .data![index];
                                          return NotificationTile(
                                              title: iteration.title.toString(),
                                              time: iteration.createdAt
                                                  .toString(),
                                              content:
                                                  iteration.body.toString());
                                        },
                                        separatorBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Divider(
                                              height: 1,
                                              color: AppColor.textGreyColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      );
                    default:
                      return Container();
                  }
                })
          ],
        ),
      ),
    );
  }
}
