import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reksti/authentication/login_screen.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/car_detail.dart';
import 'package:reksti/details/view_details.dart';
import 'package:reksti/firebase_options.dart';
import 'package:reksti/screen/home_screen.dart';
import 'package:reksti/screen/profile_screen.dart';
import 'package:reksti/screen/warning_history_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracci App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: whiteColor),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const HomeScreen(),
      routes: {
        '/details': (context) => const DetailsScreen(),
        '/view': (context) => ViewDetails(),
        '/home': (context) => const HomeScreen(),
        '/warning_history': (context) => const WarningHistoryScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
