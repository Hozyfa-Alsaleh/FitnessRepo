// ignore_for_file: avoid_print, deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/Bindings/initialbindings.dart';
import 'package:fitnessapp/core/StaticLData/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

SharedPreferences? sherdpref;
double? width;
double? height;

Future<void> onbackgroundNotify(RemoteMessage message) async {
  if (message.data != {}) {
    print("===================ON BACKGROUND");
    print(
      message.data['title'],
    );
    print(
      message.data['body'],
    );
    print("===================");
    // storNotificationsToDB(
    //     sherdpref!.getString('userId').toString(),
    //     message.data['title'],
    //     message.data['body'],
    //     DateTime.now().toString(),
    //     TimeOfDay.now().toString(),
    //     "insert");
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(onbackgroundNotify);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sherdpref = await SharedPreferences.getInstance();

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            textDirection: TextDirection.rtl,
            debugShowCheckedModeBanner: false,
            initialBinding: InitialBinding(),
            getPages: getpages,
            initialRoute: "/",
            //home: const CustomeProgressbar(),
          );
        });
  }
}
