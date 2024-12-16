import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundit/Utils/app_color.dart';
import 'package:foundit/Utils/content.dart';

class DropdownWigdet extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final List<DropdownMenuItem<dynamic>> list;
  final void Function(dynamic value) onChanged;
  // final String? Function(String?)? validator;

  DropdownWigdet(
      {super.key,
      // this.validator,
      this.labelText,
      required this.onChanged,
      required this.list,
      this.hintText});

  @override
  State<DropdownWigdet> createState() => _DropdownWigdetState();
}

class _DropdownWigdetState extends State<DropdownWigdet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Content(
                data: widget.labelText!,
                size: 18.sp,
                color: AppColor.labelColor,
              )
            : SizedBox(),
        4.verticalSpace,
        DropdownButtonFormField(
          isExpanded: false,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.orange,
          ),
          hint: widget.hintText != null
              ? Text(
                  widget.hintText!,
                  style: TextStyle(fontSize: 16.sp),
                )
              : null,
          // validator: widget.validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33.r),
                borderSide: BorderSide(width: 1, color: AppColor.lightGrey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33.r),
                borderSide: BorderSide(width: 1, color: AppColor.lightGrey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(33.r),
                borderSide: BorderSide(width: 1, color: AppColor.lightGrey)),
            isDense: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.fromLTRB(30, 16, 11, 16),
            filled: true,
            fillColor: Colors.white,
          ),
          items: widget.list,
          onChanged: widget.onChanged,
        )
      ],
    );
  }
}

class dropDownGenericType<T> {
  T? type;
  dropDownGenericType(this.type);

  dropDownGenericType.set(this.type);
}
