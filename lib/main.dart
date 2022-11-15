import 'package:flutter/material.dart';
import 'package:untitled/Screens/welcomeScreen.dart';
import 'Screens/loginScreen.dart';

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
        '/loginScreen': (context) => const LoginScreen(),
      },
      title: 'Animal Sheltering App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
    );
  }
}
