import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foundit/Model/get_boxes_model.dart';
import 'package:foundit/View/Home/AboutApp.dart';
import 'package:get/get.dart';

class FireBaseNotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      // handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // Get.snackbar(
      //     "Provisional Permission", "user granted provisional permission",
      //     snackPosition: SnackPosition.BOTTOM);
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      // Get.snackbar("Permission", "user denied permission",
      //     snackPosition: SnackPosition.BOTTOM);
      print('user denied permission');
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id, channel.name,
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      // sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    // String? token = Platform.isAndroid ? await messaging.getToken() : await messaging.getAPNSToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

  // //handle tap on notification when app is in background or terminated
  // Future<void> setupInteractMessage(BuildContext context) async {
  //   // when app is terminated
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     handleMessage(context, initialMessage);
  //   }

  //   //when app ins background
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     handleMessage(context, event);
  //   });
  // }

  // Future<void> handleMessage(BuildContext context, RemoteMessage message) async {
  //   print("MESSAGE: " + message.data.toString());

  //     Get.to(() => AboutAppScreen());

  //   // if (message.data['notificationType'] == 'post') {
  //   //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   // sp.setBool("notification", true);
  //   //   // Navigator.push(context, MaterialPageRoute(builder: ((context) => FeedUpdateDetailsScreen(isFromNotification: true, postId: message.data['redirectUrl'],))));

  //   //   Get.to(() => FeedUpdateDetailsScreen(isFromNotification: true, postId: message.data['redirectUrl'],));

  //   // }else if(message.data['notificationType'] == 'friend') {
  //   //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   // sp.setBool("notification", true);

  //   //   Get.to(() => FriendProfileScreen(userId: message.data['redirectUrl'],showRequest: true));
  //   // }

  //   // if (message.data['type'] == 'message') {
  //   //   Navigator.push(
  //   //       context,
  //   //       MaterialPageRoute(
  //   //           builder: (context) => MessageScreen(
  //   //                 id: message.data['id'],
  //   //               )));
  //   // }
  // }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
