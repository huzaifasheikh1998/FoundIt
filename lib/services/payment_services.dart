import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// import 'package:foundit/services/api_services.dart';
import 'package:http/http.dart' as http;

class CustomStripePayment {
  Map<String, dynamic>? paymentIntent;

  String calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent(
      BuildContext context, String amount, String currency) async {
    var secretKey =
        'sk_test_51MBduCFuKRZFUhc2XFTQe3OyOYKaoN5gy29rX3qon0CMRxBypjtRwhJpLTvJLnARJAIlhDzy2mrrSFYMLvXPw86600mO73gNKz';
    final uri = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final headers = {
      'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };
    log(uri.toString());
    log(headers.toString());
    log(body.toString());
    try {
      //Request body

      log(uri.toString());
      log(headers.toString());
      log(body.toString());
      //Make post request to Stripe
      final response = await http.post(uri, headers: headers, body: body);

      log(response.statusCode.toString());
      log(response.body.toString());
      Navigator.pop(context);
      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      Navigator.pop(context);
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(BuildContext context, String amount) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Color(0xffEA8806),
                ),
              ),
            ));
    try {
      paymentIntent = await createPaymentIntent(context, amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent

                  style: ThemeMode.dark,
                  merchantDisplayName: 'My'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      print('==========================> errorrr: $err');
      throw Exception(err);
    }
  }

  displayPaymentSheet(context) async {
    print("displayyyy");
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("asdsad");
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
        log("payment success");
      }).onError((error, stackTrace) {
        print('Error is:---> $error');

        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
}
