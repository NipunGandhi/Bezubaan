import 'package:flutter/material.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';
import 'package:untitled/Screens/welcomeScreen.dart';
import 'Screens/loginScreen.dart';
import 'Screens/photoChooser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        LoginScreen.name: (context) => const LoginScreen(),
        SignUpScreen.name: (context) => const SignUpScreen(),
        ForgetPasswordScreen.name: (context) => const ForgetPasswordScreen(),
        HomePageScreen.name: (context) => const HomePageScreen(),
        PhotoChooser.name: (context) => const PhotoChooser(),
      },
      title: 'Animal Sheltering App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
    );
  }
}
