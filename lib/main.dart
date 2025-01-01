import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_store_mobile/vendor/views/screens/main_vendor_screen.dart';
import 'package:multi_store_mobile/views/buyers/auth/register_screen.dart';
import 'package:multi_store_mobile/views/buyers/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Platform.isAndroid
  //     ? await Firebase.initializeApp(
  //         options: const FirebaseOptions(
  //             apiKey: 'AIzaSyCMJzfifxjxADP1eL3a9rLDdKp-WEh-wy4',
  //             appId: '1:773612231336:android:c621931342792419f9009d',
  //             messagingSenderId: '773612231336',
  //             projectId: 'my-app-d3932',
  //             storageBucket: 'gs://my-app-d3932.firebasestorage.app'),
  //       )
  //     : 
  //
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Brand-Bold',
      ),
      home: MainVendorScreen(),
    );
  }
}
