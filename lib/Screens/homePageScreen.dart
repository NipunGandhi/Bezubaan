import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/providers/currentState.dart';
import '../Widgets/postWidget.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);
  static String name = '/homePageScreen';
  final CurrentState instance = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              await instance.signOut();
              Get.offAll(WelcomeScreen());
            },
            child: Text("Logout"),
          ),
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
        ],
      ),
    );
  }
}
