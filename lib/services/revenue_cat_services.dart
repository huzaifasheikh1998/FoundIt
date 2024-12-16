import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

// import 'package:breaking_boundaries/models/offering_model';
import 'package:flutter/services.dart';
import 'package:foundit/Controller/subscription_controller.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import "package:http/http.dart" as http;

final subscriptionController = Get.put(SubscriptionController());

class RevenueCatApi {
  static String googleRevenueCatKey = "goog_STIrazbgaAQILsIGdTPZFKLKEVd";
  static String appleRevenueCatKey = "appl_VvTzatgsrsaBANbAoZxFtcSXZGJ";

  static Future configureRevenueCat() async {
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration? configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(googleRevenueCatKey);
      log("-------CONFIGURATION---- ${configuration.toString()}");
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration(appleRevenueCatKey);
      log("-------CONFIGURATION---- ${configuration.toString()}");
    }

    await Purchases.configure(configuration!);
  }

  static loginRevenueCat(String id) async {
    try {
      LogInResult loginResult = await Purchases.logIn(id);

      log("Login Successfully!!$loginResult");
    } catch (e) {}
  }

  static getCurrentOfferings() async {
    try {
      subscriptionController.isLoading.value = true;
      Offerings offerings = await Purchases.getOfferings();
      subscriptionController.yourOfferings.value = offerings;
      log(subscriptionController.yourOfferings.value.toString(),
          name: "Packages");
      if (offerings.current != null) {
        if (offerings.current!.availablePackages.isNotEmpty) {
          for (var element in offerings.current!.availablePackages) {
            // log("****element***** $element");
            // offeringModelList.add(offeringModelFromJson(json.encode(element)));
          }
        }
      }
      subscriptionController.isLoading.value = false;
      return [];
    } on PlatformException catch (e) {
      subscriptionController.isLoading.value = false;

      return [];
    }
  }

  static buySubscription(Package package) async {
    subscriptionController.isLoading.value = true;
    // chooseaplanController.isLoad(true);
    try {
      log("---------package-------- ${package.toString()}");
      log("---------store product-------- ${package.storeProduct.identifier.toString()}");
      log("---------identifier-------- ${package.identifier.toString()}");
      // String userID = await LocalStorage.readJsonString(key: LocalStorageKeys.userID);
      // loginRevenueCat(userID);
      // print("useridddddd===========> $userID");
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      log("---------Customer info on purchase--------$customerInfo");

      var isPro = customerInfo.entitlements.active.isNotEmpty;
      subscriptionController.isLoading.value = false;

      // chooseaplanController.isLoad(false);

      // var Myprice = package.storeProduct.price.toString();
      // var Mytitle = package.identifier.toString();
      log("---------Customer info on purchase--------$isPro $customerInfo");

      // if (Mytitle == "\$rc_monthly") {
      //   Mytitle = "premium_monthly";
      //   Myprice = "5.99";
      // } else if (Mytitle == "yearly_premium_offering") {
      //   Mytitle = "premium_yearly";
      //   Myprice = "54.99";
      // } else if (Mytitle == "monthly_unlimited_notes_offering") {
      //   Mytitle = "unlimited_notes_monthly";
      //   Myprice = "2.99";
      // } else if (Mytitle == "yearly_unlimited_notes_offering") {
      //   Mytitle = "unlimited_notes_yearly";
      //   Myprice = "25.99";
      // }
      if (isPro) {
        var data = {
          "title": "",
          "price": "",
        };

        // await RevenueCatApi.updateUserSubscriptionOnBackend(data);
      }
      getActiveEntitlements();
      Get.back();
      Get.back();
      return {
        'thekey': 'customerinfo',
        'thevalue': customerInfo,
        'isPurchase': true
      };
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      // chooseaplanController.isLoad(false);
      subscriptionController.isLoading.value = false;

      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.snackbar('Error', 'Purchase Cancelled',
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5),
            colorText: Colors.black,
            backgroundColor: Colors.white);

        return {
          'thekey': 'exception',
          'thevalue': errorCode.toString(),
          'isPurchase': false
        };
      } else {
        Get.snackbar(
          'Error',
          'Subscription Error',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          colorText: Colors.white,
        );
        return {
          'thekey': 'exception',
          'thevalue': errorCode.toString(),
          'isPurchase': false
        };
      }
    } catch (e) {
      // chooseaplanController.isLoad(false);
      subscriptionController.isLoading.value = false;
      Get.snackbar(
        'Error $e',
        'Subscription Error',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        colorText: Colors.white,
      );
      return {'thekey': 'exception', 'thevalue': null};
    }
  }

  // static buySubscription(Package package) async {
  //   subscriptionController.isLoading.value=true;
  //   try {
  //     log("---------package-------- ${package.toString()}");
  //     // String userID = await LocalStorage.readJsonString(key: LocalStorageKeys.userID);
  //     await loginRevenueCat(userID); // Ensure this is awaited if it's an async function
  //     print("useridddddd===========> $userID");
  //
  //     CustomerInfo? customerInfo; // Initialize as nullable
  //     bool purchaseCompleted = false;
  //
  //     print("STEP 5 ===========> $userID");
  //     customerInfo = await Purchases.purchasePackage(package);
  //
  //     log("---------Customer info on purchase--------$customerInfo");
  //
  //     var isPro = customerInfo.entitlements.active.isNotEmpty;
  //
  //     subscriptionController.isLoad(false);
  //
  //     log("---------Customer info on purchase--------$isPro $customerInfo");
  //
  //     if (isPro) {
  //       var data = {
  //         "title": package.storeProduct.title,
  //         "price": package.storeProduct.priceString,
  //       };
  //
  //       // Uncomment and implement this if needed
  //       // await RevenueCatApi.updateUserSubscriptionOnBackend(data);
  //     }
  //     Get.back();
  //     Get.back();
  //     return {'thekey': 'customerinfo', 'thevalue': customerInfo, 'isPurchase': true};
  //   } on PlatformException catch (e) {
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     subscriptionController.isLoad(false);
  //
  //     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
  //       Get.snackbar('Error', 'Purchase Cancelled',
  //           snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 5), colorText: Colors.black, backgroundColor: Colors.white);
  //
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Subscription Error',
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 5),
  //         colorText: Colors.white,
  //       );
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     }
  //   } catch (e) {
  //     subscriptionController.isLoad(false);
  //
  //     Get.snackbar(
  //       'Error',
  //       'Subscription Error',
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 5),
  //       colorText: Colors.white,
  //     );
  //     return {'thekey': 'exception', 'thevalue': e.toString()};
  //   }
  // }
  //
  // static buySubscriptionwithEligibilityCheck(Package package) async {
  //   subscriptionController.isLoad(true);
  //   try {
  //     log("---------package-------- ${package.toString()}");
  //     String userID = await LocalStorage.readJsonString(key: LocalStorageKeys.userID);
  //     await loginRevenueCat(userID); // Ensure this is awaited if it's an async function
  //     print("useridddddd===========> $userID");
  //
  //     CustomerInfo? customerInfo; // Initialize as nullable
  //     bool purchaseCompleted = false;
  //
  //     if (Platform.isIOS) {
  //       // Attempt to check trial or introductory price eligibility
  //       try {
  //         Map<String, IntroEligibility> introEligibility =
  //         await Purchases.checkTrialOrIntroductoryPriceEligibility([package.storeProduct.identifier]);
  //
  //         if (introEligibility[package.storeProduct.identifier]?.status == IntroEligibilityStatus.introEligibilityStatusEligible) {
  //           // User is eligible for trial or introductory price
  //           PromotionalOffer? promotionalOffer;
  //           if (package.storeProduct.discounts != null && package.storeProduct.discounts!.isNotEmpty) {
  //             try {
  //               promotionalOffer = await Purchases.getPromotionalOffer(
  //                 package.storeProduct,
  //                 package.storeProduct.discounts!.first, // Assuming you are using the first discount
  //               );
  //
  //               // Purchase with promotional offer
  //               customerInfo = await Purchases.purchaseDiscountedPackage(package, promotionalOffer);
  //               purchaseCompleted = true;
  //             } on PlatformException catch (e) {
  //               var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //               log("Error while getting promotional offer: $errorCode");
  //
  //               if (errorCode != PurchasesErrorCode.ineligibleError) {
  //                 // Show the paywall even if ineligible
  //                 rethrow; // Re-throw if it's a different error
  //               }
  //             }
  //           }
  //         }
  //       } catch (e) {
  //         log("Error checking trial or introductory price eligibility: $e");
  //       }
  //     }
  //
  //     if (!purchaseCompleted) {
  //       // Regular purchase
  //       customerInfo = await Purchases.purchasePackage(package);
  //     }
  //
  //     if (customerInfo == null) {
  //       // Handle the case where customerInfo is still null
  //       throw Exception('Failed to complete the purchase');
  //     }
  //
  //     log("---------Customer info on purchase--------$customerInfo");
  //
  //     var isPro = customerInfo.entitlements.active.isNotEmpty;
  //
  //     subscriptionController.isLoad(false);
  //
  //     log("---------Customer info on purchase--------$isPro $customerInfo");
  //
  //     if (isPro) {
  //       var data = {
  //         "title": package.storeProduct.title,
  //         "price": package.storeProduct.priceString,
  //       };
  //
  //       // Uncomment and implement this if needed
  //       // await RevenueCatApi.updateUserSubscriptionOnBackend(data);
  //     }
  //     Get.back();
  //     Get.back();
  //     return {'thekey': 'customerinfo', 'thevalue': customerInfo, 'isPurchase': true};
  //   } on PlatformException catch (e) {
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     subscriptionController.isLoad(false);
  //
  //     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
  //       Get.snackbar('Error', 'Purchase Cancelled',
  //           snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 5), colorText: Colors.black, backgroundColor: Colors.white);
  //
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Subscription Error',
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 5),
  //         colorText: Colors.white,
  //       );
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     }
  //   } catch (e) {
  //     subscriptionController.isLoad(false);
  //
  //     Get.snackbar(
  //       'Error',
  //       'Subscription Error',
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 5),
  //       colorText: Colors.white,
  //     );
  //     return {'thekey': 'exception', 'thevalue': e.toString()};
  //   }
  // }
  //
  // static buySubscription1(Package package) async {
  //   subscriptionController.isLoad(true);
  //   try {
  //     log("---------package-------- ${package.toString()}");
  //     String userID = await LocalStorage.readJsonString(key: LocalStorageKeys.userID);
  //     await loginRevenueCat(userID); // Ensure this is awaited if it's an async function
  //     print("useridddddd===========> $userID");
  //     CustomerInfo customerInfo;
  //     if (Platform.isIOS) {
  //       // Attempt to get the promotional offer
  //       PromotionalOffer? promotionalOffer;
  //       print("STEP 1 ===========> $userID");
  //
  //       if (package.storeProduct.discounts!.isNotEmpty) {
  //         print("STEP 2 ===========> $userID");
  //         promotionalOffer = await Purchases.getPromotionalOffer(
  //           package.storeProduct,
  //           package.storeProduct.discounts!.first, // Assuming you are using the first discount
  //         );
  //         print("STEP 3 ===========> $userID");
  //       }
  //
  //       if (promotionalOffer != null) {
  //         print("STEP 4 ===========> $userID");
  //         // Purchase with promotional offer
  //         customerInfo = await Purchases.purchaseDiscountedPackage(package, promotionalOffer);
  //       } else {
  //         // Regular purchase
  //         print("STEP 5 ===========> $userID");
  //         customerInfo = await Purchases.purchasePackage(package);
  //       }
  //     } else {
  //       customerInfo = await Purchases.purchasePackage(package);
  //     }
  //
  //     log("---------Customer info on purchase--------$customerInfo");
  //
  //     var isPro = customerInfo.entitlements.active.isNotEmpty;
  //
  //     subscriptionController.isLoad(false);
  //
  //     log("---------Customer info on purchase--------$isPro $customerInfo");
  //
  //     if (isPro) {
  //       var data = {
  //         "title": package.storeProduct.title,
  //         "price": package.storeProduct.priceString,
  //       };
  //
  //       // Uncomment and implement this if needed
  //       // await RevenueCatApi.updateUserSubscriptionOnBackend(data);
  //     }
  //     Get.back();
  //     Get.back();
  //     return {'thekey': 'customerinfo', 'thevalue': customerInfo, 'isPurchase': true};
  //   } on PlatformException catch (e) {
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     subscriptionController.isLoad(false);
  //
  //     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
  //       Get.snackbar('Error', 'Purchase Cancelled',
  //           snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 5), colorText: Colors.black, backgroundColor: Colors.white);
  //
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Subscription Error',
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: const Duration(seconds: 5),
  //         colorText: Colors.white,
  //       );
  //       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
  //     }
  //   } catch (e) {
  //     subscriptionController.isLoad(false);
  //
  //     Get.snackbar(
  //       'Error',
  //       'Subscription Error',
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 5),
  //       colorText: Colors.white,
  //     );
  //     return {'thekey': 'exception', 'thevalue': e.toString()};
  //   }
  // }

// static buySubscription(Package package) async {
//   chooseaplanController.isLoad(true);
//   try {
//     log("---------package-------- ${package.toString()}");
//     String userID = await LocalStorage.readJsonString(key: LocalStorageKeys.userID);
//     await loginRevenueCat(userID); // Ensure this is awaited if it's an async function
//     print("useridddddd===========> $userID");

//     CustomerInfo? customerInfo; // Initialize as nullable
//     bool purchaseCompleted = false;

//     if (Platform.isIOS) {
//       // Attempt to get the promotional offer
//       PromotionalOffer? promotionalOffer;
//       print("STEP 1 ===========> $userID");

//       if (package.storeProduct.discounts != null && package.storeProduct.discounts!.isNotEmpty) {
//         try {
//           print("STEP 2 ===========> ${package.storeProduct.discounts}");
//           promotionalOffer = await Purchases.getPromotionalOffer(
//             package.storeProduct,
//             package.storeProduct.discounts!.first, // Assuming you are using the first discount
//           );
//           print("STEP 3 ===========> $promotionalOffer");

//           if (promotionalOffer != null) {
//             print("STEP 4 ===========> $userID");
//             // Purchase with promotional offer
//             customerInfo = await Purchases.purchaseDiscountedPackage(package, promotionalOffer);
//             purchaseCompleted = true;
//           }
//         } on PlatformException catch (e) {
//           var errorCode = PurchasesErrorHelper.getErrorCode(e);
//           log("Error while getting promotional offer: $errorCode");

//           if (errorCode != PurchasesErrorCode.ineligibleError) {
//             throw e; // Re-throw if it's a different error
//           }
//         }
//       } else {
//         log("No discounts available for the product.");
//       }
//     }

//     if (!purchaseCompleted) {
//       // Regular purchase
//       print("STEP 5 ===========> $userID");
//       customerInfo = await Purchases.purchasePackage(package);
//     }

//     if (customerInfo == null) {
//       // Handle the case where customerInfo is still null
//       throw Exception('Failed to complete the purchase');
//     }

//     log("---------Customer info on purchase--------$customerInfo");

//     var isPro = customerInfo.entitlements.active.isNotEmpty;

//     chooseaplanController.isLoad(false);

//     log("---------Customer info on purchase--------$isPro $customerInfo");

//     if (isPro) {
//       var data = {
//         "title": package.storeProduct.title,
//         "price": package.storeProduct.priceString,
//       };

//       // Uncomment and implement this if needed
//       // await RevenueCatApi.updateUserSubscriptionOnBackend(data);
//     }
//     Get.back();
//     Get.back();
//     return {'thekey': 'customerinfo', 'thevalue': customerInfo, 'isPurchase': true};
//   } on PlatformException catch (e) {
//     var errorCode = PurchasesErrorHelper.getErrorCode(e);
//     chooseaplanController.isLoad(false);

//     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
//       Get.snackbar('Error', 'Purchase Cancelled', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 5), colorText: Colors.black, backgroundColor: Colors.white);

//       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
//     } else {
//       Get.snackbar(
//         'Error',
//         'Subscription Error',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: Duration(seconds: 5),
//         colorText: Colors.white,
//       );
//       return {'thekey': 'exception', 'thevalue': errorCode.toString(), 'isPurchase': false};
//     }
//   } catch (e) {
//     chooseaplanController.isLoad(false);

//     Get.snackbar(
//       'Error',
//       'Subscription Error',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 5),
//       colorText: Colors.white,
//     );
//     return {'thekey': 'exception', 'thevalue': e.toString()};
//   }
// }

// Add this method to retrieve the promotional offer

  static Future<EntitlementInfos?> getActiveEntitlements() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      log("///get active entitlements///\n" + customerInfo.toString());
      if (customerInfo.activeSubscriptions.isNotEmpty) {
        if (customerInfo.activeSubscriptions.first.toString() ==
            "monthly_plan:monthly-plan-9") {
          subscriptionController.subscriptionIndex.value = 1;
        } else {
          subscriptionController.subscriptionIndex.value = 2;
        }
      }
      // var subscriptionName = await LocalStorage.readJsonString(key: LocalStorageKeys.subscriptionName);
      // if (subscriptionName == "Free trial") {
      //   log("=============Actiėasdasdasdasdasdasdasdasdasde");
      //   customerInfo = CustomerInfo(EntitlementInfos({}, {}), {}, [], [], [], "", "", {}, "");
      //   // return customerInfo.entitlements;
      // }
      // var data = log("Customer Info " + customerInfo.toString());
      // else {

      // subscriptionController.subscriptionIndex.value =
      return customerInfo.entitlements;
      // }
    } on PlatformException catch (e) {
      return null;
    }
  }
}
