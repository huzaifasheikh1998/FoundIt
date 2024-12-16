import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foundit/NavBar/Navbar.dart';
import 'package:foundit/Repo/notification_repo.dart';
import 'package:foundit/View/Auth/ForgotPassword.dart';
import 'package:foundit/View/Auth/Login.dart';
import 'package:foundit/View/Auth/Otp.dart';
import 'package:foundit/View/Auth/PhoneVerification.dart';
import 'package:foundit/View/Auth/PreLogin.dart';
import 'package:foundit/View/Auth/Signup.dart';
import 'package:foundit/View/Home/AboutApp.dart';
import 'package:foundit/View/Home/AddNewMember.dart';
import 'package:foundit/View/Home/Boxfilter.dart';
import 'package:foundit/View/Home/EnterYouAddress.dart';
import 'package:foundit/View/Home/Filter.dart';
import 'package:foundit/View/Home/FilterResult(3%20Boxes).dart';
import 'package:foundit/View/Home/Foundit.dart';
import 'package:foundit/View/Home/Home.dart';
import 'package:foundit/View/Home/OrderHistory.dart';
import 'package:foundit/View/Home/PrivacyPolicy.dart';
import 'package:foundit/View/Home/RateThisApp.dart';
import 'package:foundit/View/Home/Search.dart';
import 'package:foundit/View/Home/SelectPaymentMethod.dart';
import 'package:foundit/View/Home/Settings.dart';
import 'package:foundit/View/Home/SubscriptionPackages.dart';
import 'package:foundit/ViewModel/notification_view_model.dart';
import 'package:foundit/ViewModel/order_detail_view_model.dart';
import 'package:foundit/services/add_mob_helper.dart';
import 'package:foundit/services/revenue_cat_services.dart';
import 'package:foundit/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'View/Auth/CreateNewPasword.dart';
import 'View/Home/AddNewBox.dart';
import 'View/Home/MySavedQr.dart';
import 'View/Home/Terms&Condiciton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

late OrderDetailViewModel orderDetailViewModel;

final getIt = GetIt.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  print(message.notification!.title.toString());
  print(message.notification.toString());
}

@pragma('vm:entry-point')
Future<void> main() async {
  getIt.registerSingleton<NotificationRepo>(NotificationRepo());
  getIt.registerSingleton(NotificationViewModel(getIt()));
  orderDetailViewModel = OrderDetailViewModel();
  WidgetsFlutterBinding.ensureInitialized();
  AdmobHelper.initialization();

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Stripe.publishableKey =
      "pk_test_51MBduCFuKRZFUhc2cTQeQ9ITUA5D2foBdcJwkBV5eXVuOafC47SAL4HSz0c5dX47k0JZ4kHOqFBQKhhrMmYGp56z00yPTjXaLK";

  await Stripe.instance.applySettings();
  await RevenueCatApi.configureRevenueCat();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(428, 926),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          initialRoute: '/SplashScreen',
          getPages: [
            GetPage(
              name: '/SplashScreen',
              page: (() => SplashScreen()),
            ),
            GetPage(
              name: '/PreLoginScreen',
              page: (() => PreLoginScreen()),
            ),
            GetPage(
              name: '/LoginScreen',
              page: (() => LoginScreen()),
            ),
            GetPage(
              name: '/SignupScreen',
              page: (() => SignupScreen()),
            ),
            GetPage(
              name: '/ForgotPasswordScreen',
              page: (() => ForgotPasswordScreen()),
            ),
            GetPage(
              name: '/OtpScreen',
              page: (() => OtpScreen()),
            ),
            GetPage(
              name: '/CreateNewPaswordScreen',
              page: (() => CreateNewPaswordScreen()),
            ),
            GetPage(
              name: '/PhoneVerificationScreen',
              page: (() => PhoneVerificationScreen()),
            ),
            // GetPage(
            //   name: '/SignupOtpScreen',
            //   page: (() => SignupOtpScreen()),
            // ),
            GetPage(
              name: '/HomeScreen',
              page: (() => HomeScreen()),
            ),
            // GetPage(
            //   name: '/Box1Screen',
            //   page: (() => Box1Screen()),
            // ),
            GetPage(
              name: '/SearchScreen',
              page: (() => SearchScreen()),
            ),
            GetPage(
              name: '/SettingsScreen',
              page: (() => SettingsScreen()),
            ),
            GetPage(
              name: '/AboutAppScreen',
              page: (() => AboutAppScreen()),
            ),
            GetPage(
              name: '/PrivacyPolicyScreen',
              page: (() => PrivacyPolicyScreen()),
            ),
            GetPage(
              name: '/TermsAndCondicitonScreen',
              page: (() => TermsAndCondicitonScreen()),
            ),
            GetPage(
              name: '/RateThisAppScreen',
              page: (() => RateThisAppScreen()),
            ),
            GetPage(
              name: '/AddNewMemberScreen',
              page: (() => AddNewMemberScreen()),
            ),
            // GetPage(
            //   name: '/AddNewItemScreen',
            //   page: (() => AddNewItemScreen()),
            // ),
            GetPage(
              name: '/FilterScreen',
              page: (() => FilterScreen()),
            ),
            GetPage(
              name: '/FilterResultScreen',
              page: (() => FilterResultScreen(
                    boxList: [],
                  )),
            ),
            GetPage(
              name: '/BoxfilterScreen',
              page: (() => BoxfilterScreen()),
            ),
            GetPage(
              name: '/EnterYouAddressScreen',
              page: (() => EnterYouAddressScreen()),
            ),
            GetPage(
              name: '/SelectPaymentMethodScreen',
              page: (() => SelectPaymentMethodScreen()),
            ),
            // GetPage(
            //   name: '/AddCardScreen',
            //   page: (() => AddCard()),
            // ),
            GetPage(
              name: '/MySavedQrScreen',
              page: (() => MySavedQrScreen()),
            ),
            GetPage(
              name: '/AddNewBoxScreen',
              page: (() => AddNewBoxScreen()),
            ),
            GetPage(
              name: '/MainScreen',
              page: (() => MainScreen()),
            ),
            GetPage(
              name: '/FounditScreen',
              page: (() => FounditScreen()),
            ),
            GetPage(
              name: '/SubscriptionPackagesScreen',
              page: (() => SubscriptionPackagesScreen()),
            ),
            GetPage(
              name: '/OrderHistoryScreen',
              page: (() => OrderHistoryScreen()),
            ),
          ],
        );
      },
    );
  }
}
