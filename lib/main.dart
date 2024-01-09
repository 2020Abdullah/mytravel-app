import 'package:flutter/material.dart';
import 'package:mytravel/screens/CategoryTrip_screen.dart';
import 'package:mytravel/screens/Home_screen.dart';
import 'package:mytravel/screens/Login_screen.dart';
import 'package:mytravel/screens/SignUp_screen.dart';
import 'package:mytravel/screens/Profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context){
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'دليل سياحي',
      initialRoute: "/",
      routes: {
        "/": (context) => Login_screen(),
        "SignUp": (context) => SignUp_screen(),
        "Home": (context) => Home_screen(),
        "CategoryInfo": (context) => CategoryTrip_screen(),
        "profile": (context) => Profile_screen(),
      },
    );
  }
}

