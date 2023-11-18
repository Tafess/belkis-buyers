import 'dart:async';
import 'dart:io';
import 'package:belkis/screens/on_boarding_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyCNe29nuXAiR0Q9H6rnOm3y2DsEDaqHmgo",
            appId: "1:359678373942:android:30ef639879adee694a6897",
            messagingSenderId: "359678373942",
            projectId: "belkis-marketplace",
            storageBucket: "belkis-marketplace.appspot.com",
          )
        : null,
  );

  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor:
        Colors.transparent, // Make the status bar background transparent
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belkis marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnBoardingScreen.id: (context) => const OnBoardingScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});
  static const String id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      bool? _boarding = store.read('onBoarding');
      // Check if it's the first time or not
      if (_boarding == null) {
        Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, MainScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Center(child: Image.asset('assets/images/welcome.png')),
    );
  }
}
