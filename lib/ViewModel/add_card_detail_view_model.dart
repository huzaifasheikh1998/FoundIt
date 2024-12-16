import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foundit/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCardDetailViewModel extends GetxController {
  TextEditingController cardHolderController =
      TextEditingController(text: !kDebugMode ? null : "charles mark");
  TextEditingController cardNoController =
      TextEditingController(text: !kDebugMode ? null : "4242424242424242");
  TextEditingController expiryDateController =
      TextEditingController(text: !kDebugMode ? null : '02-24');
  TextEditingController cvcController =
      TextEditingController(text: !kDebugMode ? null : '323');

  Future<void> selectExpiryDate(BuildContext context) async {
    DateTime? picked;
    picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        currentDate: DateTime.now(),
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 30)));
    if (picked != null && picked != DateTime.now()) {
      expiryDateController.text = new DateFormat("MM-yy").format(picked);
      print(expiryDateController.text);
    }
  }

  validate(BuildContext context) {
    if (!Utils.validateFullName(cardHolderController, 'Card Holder')) {
      return;
    } else if (!Utils.validate(cardNoController, "Card Number")) {
      return;
    } else if (!Utils.validate(expiryDateController, "Expiry Date")) {
      return;
    } else if (!Utils.validate(cvcController, "CVC Number")) {
      return;
    } else {
      Map<String, dynamic> cardDetailData = {
        'card_holder_name': cardHolderController.text,
        'number': cardNoController.text,
        'exp_month': DateFormat('MM')
            .format(DateFormat('MM-yy').parse(expiryDateController.text)),
        'exp_year': DateFormat('yy')
            .format(DateFormat('MM-yy').parse(expiryDateController.text)),
        'cvc': cvcController.text,
      };
      log(cardDetailData.toString(), name: "card detail data");
      Navigator.pop(context, cardDetailData);
    }
  }
}
