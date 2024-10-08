import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pharmacy_clients/firebase_options.dart';

import 'package:pharmacy_clients/views/screens/main_screen.dart';
import 'package:pharmacy_clients/views/screens/navbar.dart';

import 'controller/clients_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AddClientsController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       log('=========User is currently signed out!');
  //     } else {
  //       log('========User is signed in!');
  //     }
  //   });
  //   super.initState();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
        ),
       
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: HexColor('efeee5'),
        appBarTheme: AppBarTheme(backgroundColor: HexColor('efeee5')),
        cardTheme: const CardTheme(color: Colors.white),
        useMaterial3: true,
      ),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const Text("there Error");
          }
          // ignore: unnecessary_null_comparison
          if (snapshot.data == null) {
            return const MainScreen();
          }
          if (snapshot.hasData) {
            log(snapshot.data.toString());
            return const NavBar();
          }
          return const Text("");
        },
      ),
      // home: RegisterScreen(),
      // builder: EasyLoading.init(),
      //getPages: [GetPage(name: '/home', page: () => HomeScreen())],
    );
  }
}


