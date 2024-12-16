import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Data/response/status.dart';
import 'package:foundit/Repo/scan_qr_repo.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:foundit/ViewModel/scan_qr_view_model.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  var controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );
  ScanQrViewModel scanQrViewModel = ScanQrViewModel(ScanQrRepo());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.grey,
        appBar: AppBar(
          leadingWidth: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Content(
            data: "Scan Qr",
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
        body: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  String qrCodeValue = ((barcodes.first.displayValue
                      ?.split("//")
                      .last
                      .split("/")
                      .first) ??
                      null)
                      .toString();
                  qrCodeValue;
                  if (qrCodeValue != "null") {
                    scanQrViewModel.fetchScanApiResponse(qrCodeValue);
                  } else if (Get.currentRoute == "/ScanQrScreen") {
                    Get.back();
                    Utils.showSnackBar(type: false, msg: "Wrong Qr");
                  }
                }
              },
            ),
            GetBuilder(
                init: scanQrViewModel,
                builder: (value) {
                  return value.scanApiResponse.status == Status.LOADING
                      ? Utils.showLoading(context)
                      : SizedBox();
                })
          ],
        ));
  }
}