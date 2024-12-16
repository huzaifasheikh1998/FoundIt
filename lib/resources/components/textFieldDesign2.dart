// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foundit/Utils/app_color.dart';
// import 'package:foundit/Utils/content.dart';

// class TextFieldDesign1 extends StatelessWidget {
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final List<TextInputFormatter>? inputFormat;
//   final String? hint;
//   final String? label;
//   final String? prefixAsset;
//   final Widget? prefixWidget;
//   final String? suffixAsset;

//   final Widget? suffixWidget;
//   final bool readOnly;
//   final int? maxLength;
//   final Function()? onTap;
//   TextFieldDesign1(
//       {super.key,
//       required this.controller,
//       this.inputType,
//       this.inputFormat,
//       this.hint,
//       this.label,
//       this.prefixAsset,
//       this.suffixAsset,
//       this.readOnly = false,
//       this.maxLength,
//       this.onTap,
//       this.prefixWidget,
//       this.suffixWidget});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         label != null
//             ? Content(
//                 data: label!,
//                 size: 18.sp,
//                 color: AppColor.labelColor,
//               )
//             : SizedBox(),
//         4.verticalSpace,
//         Container(
//           // width: 380.w,
//           height: 70.h,
//           margin: EdgeInsets.only(bottom: 12),
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(33.r),
//             border: Border.all(color:  Color(0xff7E91B1), width: 1),
//             color: Colors.white,
//           ),
//           child: Center(
//             child: TextFormField(
//               maxLength: maxLength,
//               readOnly: readOnly,
//               onTap: onTap,
//               controller: controller,
//               keyboardType: inputType,
//               inputFormatters: inputFormat,
//               decoration: InputDecoration(
//                   counterText: '',
//                   alignLabelWithHint: true,
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   disabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   prefixIcon: prefixAsset != null
//                       ? Image.asset(
//                           prefixAsset!,
//                           scale: 3,
//                         )
//                       : prefixWidget,
//                   suffixIcon: suffixAsset != null
//                       ? Image.asset(
//                           suffixAsset!,
//                           scale: 3,
//                         )
//                       : suffixWidget,
//                   hintText: hint,
//                   hintStyle: TextStyle(
//                     fontSize: 18.sp,
//                     color: Colors.black.withOpacity(0.59),
//                     fontFamily: "Roboto, Regular",
//                   )),
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
