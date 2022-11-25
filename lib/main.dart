import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'Screens/loginScreen.dart';
import 'Screens/photoChooser.dart';
import 'models/ourUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(OurUserDetailOriginal());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        LoginScreen.name: (context) => LoginScreen(),
        SignUpScreen.name: (context) => SignUpScreen(),
        ForgetPasswordScreen.name: (context) => const ForgetPasswordScreen(),
        HomePageScreen.name: (context) => HomePageScreen(),
        PhotoChooser.name: (context) => const PhotoChooser(),
        NewPostWidget.name: (context) => NewPostWidget(),
      },
      title: 'Animal Sheltering App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
    );
  }
}
