import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/Reader.dart';
import 'package:news_app/screens/Witer.dart';
import 'package:news_app/screens/read_write.dart';
import 'package:news_app/screens/upiTransaction.dart';

import 'screens/cart.dart';
import 'screens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(GetMaterialApp(home: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        'login':(context)=>LoginScreen(),
        'writer':(context)=>WriterScreen(),
        'reader':(context)=>ReaderScreen(),
        'cart':(context)=>CartScreen(),
        'readwrite':(context)=>ReadWriteScreen(),

      },

    home: Scaffold(
         body : StreamBuilder<User?>(
        stream: FirebaseAuth. instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ReadWriteScreen();
          }
            else
            return LoginScreen();
        }
    )
    ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    return LoginScreen();
  }
}