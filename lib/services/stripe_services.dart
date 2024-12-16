import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:foundit/services/api_services.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../Model/plans.dart';

class StripeController extends GetxController {
  Map<String, String> _headers = {
    'Authorization':
        'Bearer sk_test_51MBduCFuKRZFUhc2XFTQe3OyOYKaoN5gy29rX3qon0CMRxBypjtRwhJpLTvJLnARJAIlhDzy2mrrSFYMLvXPw86600mO73gNKz',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  void _init() {
    Stripe.publishableKey =
        'pk_test_51MBduCFuKRZFUhc2cTQeQ9ITUA5D2foBdcJwkBV5eXVuOafC47SAL4HSz0c5dX47k0JZ4kHOqFBQKhhrMmYGp56z00yPTjXaLK';
  }

  Future<bool?> subscriptions(
      {required String name,
      required BuildContext context,
      required String email,
      required CardDetails cardDetails,
      required Plan plans}) async {
    final price = ((num.tryParse(plans.amount.toString() ?? '0') ?? 0));
    _init();
    final _customer = await _createCustomer(
      email: email,
      name: name,
    );
    final _paymentMethod = await _createPaymentMethod(cardDetails: cardDetails);
    final Map<String, dynamic> priceId = await _createPlans(
        amount: price,
        name: plans.planName ?? '',
        interval: plans.billingPeriod ?? '',
        currency: 'usd');
    await _attachPaymentMethod(_paymentMethod['id'], _customer['id']);
    await _updateCustomer(_paymentMethod['id'], _customer['id']);
    final Map<String, dynamic> response =
        await _createSubscriptions(_customer['id'], priceId: priceId['id']);

    final Map<String, dynamic> map = {
      'subscription_id': response['id'],
      'customer_id': _customer['id'],
      'price_id': priceId['id'],
      'plan_id': plans.planId,
      'status': 'active'
    };

    await ApiServices().createSubscriptionPlan(context, map);
    log(response.toString());
    return true;
  }

  Future<Map<String, dynamic>> _createCustomer({
    required String email,
    required String name,
  }) async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: {'email': email, 'name': name},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> _updateCustomer(
      String paymentMethodId, String customerId) async {
    final String url = 'https://api.stripe.com/v1/customers/$customerId';

    var response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to update Customer.';
    }
  }

  Future<Map<String, dynamic>> _createPaymentMethod(
      {required CardDetails cardDetails}) async {
    final String url = 'https://api.stripe.com/v1/payment_methods';
    var response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: {
        'type': 'card',
        'card[number]': '${cardDetails.number}',
        'card[exp_month]': '${cardDetails.expirationMonth}',
        'card[exp_year]': '${cardDetails.expirationYear}',
        'card[cvc]': '${cardDetails.cvc}',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw "Invalid Card Details";
    }
  }

  Future<Map<String, dynamic>> _attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    final String url =
        'https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach';
    var response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: {
        'customer': customerId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to attach PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> _createSubscriptions(String customerId,
      {required String priceId}) async {
    final String url = 'https://api.stripe.com/v1/subscriptions';

    final Map<String, dynamic> body = {
      'customer': customerId,
      'items[0][price]': priceId,
    };

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<Map<String, dynamic>> _createPlans({
    required num amount,
    required String name,
    required String interval,
    required String currency,
  }) async {
    final price = amount * 100;

    final String url = 'https://api.stripe.com/v1/plans';
    final Map<String, dynamic> product = await _createProducts(name: name);
    Map<String, dynamic> body = {
      'amount': '${price.toInt()}',
      'currency': currency,
      'interval': interval,
      'product': product['id']
    };

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<Map<String, dynamic>> _createProducts({required String name}) async {
    final String url = 'https://api.stripe.com/v1/products';

    Map<String, dynamic> body = {'name': name};

    var response =
        await http.post(Uri.parse(url), headers: _headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }
}
