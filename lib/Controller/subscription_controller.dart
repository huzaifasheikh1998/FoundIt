import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionController extends GetxController{

  RxBool isLoading= false.obs;
  Rx<Offerings> yourOfferings = Offerings({}).obs;
  // CustomerInfo customerInfo = CustomerInfo(entitlements, allPurchaseDates, activeSubscriptions, allPurchasedProductIdentifiers, nonSubscriptionTransactions, firstSeen, originalAppUserId, allExpirationDates, requestDate)
 RxInt subscriptionIndex= 0.obs;
}