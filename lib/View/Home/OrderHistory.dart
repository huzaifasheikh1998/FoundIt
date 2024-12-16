import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/order_history_view_model.dart';
import 'package:foundit/resources/components/history_tab_bar.dart';
import 'package:foundit/resources/components/history_tile.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderHistoryViewModel orderHistoryViewModel =
      Get.put(OrderHistoryViewModel());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await orderHistoryViewModel.fetchOrderHistoryResponse();
    });
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: false,
          extendBodyBehindAppBar: false,
          backgroundColor: AppColor.grey,
          appBar: AppBar(
            leadingWidth: 70,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Content(
              data: "Order History",
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
                GetBuilder<OrderHistoryViewModel>(
                    init: orderHistoryViewModel,
                    builder: (value) {
                      switch (value.orderHistoryResponse.status) {
                        case Status.INIT:
                          return Container();
                        case Status.LOADING:
                          return Utils.showLoading(context);
                        case Status.ERROR:
                          return Utils.showError(
                              value.orderHistoryResponse.message.toString());
                        case Status.COMPLETED:
                          return Expanded(
                            child: Column(
                              children: [
                                HistoryTabBar(
                                  controller: value,
                                ),
                                10.h.verticalSpace,
                                value.selectedData!.isEmpty
                                    ? Utils.showError("No Order Found")
                                    : Expanded(
                                        child: Container(
                                        // height: 0.765.sh,
                                        clipBehavior: Clip.none,
                                        child: ListView.separated(
                                          clipBehavior: Clip.hardEdge,
                                          itemCount: value.selectedData!.length,
                                          shrinkWrap: true,
                                          // physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final iteration =
                                                value.selectedData?[index];
                                            int lastIndex = iteration?.size
                                                    ?.lastIndexOf("-") ??
                                                0;

                                            return Column(
                                              children: [
                                                70.h.verticalSpace,
                                                HistoryTile(
                                                    orderId: iteration
                                                            ?.externalId
                                                            .toString() ??
                                                        "",
                                                    status: iteration?.status
                                                            .toString() ??
                                                        "",
                                                    size: iteration?.size
                                                            ?.substring(
                                                                lastIndex + 1)
                                                            .trim() ??
                                                        "",
                                                    address: iteration
                                                            ?.address?.address1
                                                            .toString() ??
                                                        "",
                                                    quantity: iteration
                                                            ?.quantity
                                                            .toString() ??
                                                        "",
                                                    amount: iteration?.amount
                                                            .toString() ??
                                                        ""),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return 1.verticalSpace;
                                          },
                                        ),
                                      ))
                              ],
                            ),
                          );
                        default:
                          return Container();
                      }
                    })
              ],
            ),
          )),
    );
  }
}
