import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/my_saved_qr_view_model.dart';
import 'package:foundit/resources/components/saved_qr_tile.dart';
import 'package:get/get.dart';

class MySavedQrScreen extends StatefulWidget {
  MySavedQrScreen({super.key});

  @override
  State<MySavedQrScreen> createState() => _MySavedQrScreenState();
}

class _MySavedQrScreenState extends State<MySavedQrScreen> {
  MySavedQrViewModel mySavedQrViewModel = Get.put(MySavedQrViewModel());

  @override
  void didChangeDependencies() {
    mySavedQrViewModel.fetchMySaveQrResponse();
    super.didChangeDependencies();
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
          "My Saved Qr",
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.verticalSpace,
                GetBuilder<MySavedQrViewModel>(
                    init: mySavedQrViewModel,
                    builder: (value) {
                      switch (value.mySaveQrResponse.status) {
                        case Status.INIT:
                          return Container();
                        case Status.LOADING:
                          return Utils.showLoading(context);
                        case Status.ERROR:
                          return Utils.showError(
                              value.mySaveQrResponse.message.toString());
                        case Status.COMPLETED:
                          return Column(
                            children: [
                              25.verticalSpace,
                              value.mySaveQrResponse.data?.data?.length == 0
                                  ? Utils.showError("No Saved Qr Found")
                                  : ListView.separated(
                                      itemCount: value.mySaveQrResponse.data
                                              ?.data?.length ??
                                          0,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final iteration = value.mySaveQrResponse
                                            .data?.data?[index];
                                        return SavedQrTile(data: iteration!);
                                      },
                                      separatorBuilder: (context, index) {
                                        return 30.verticalSpace;
                                      },
                                    )
                            ],
                          );
                        default:
                          return Container();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
