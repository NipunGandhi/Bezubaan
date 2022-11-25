import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'package:untitled/providers/currentState.dart';
import '../Widgets/postWidget.dart';
import 'package:untitled/Widgets/new_post_model.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);
  final CurrentState instance = Get.find();
  static String name = "/HomePageScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bezubaan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile Page',
            onPressed: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Profile Page')));
              await Navigator.pushNamed(context, ProfileScreen.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            tooltip: 'Add Photo',
            onPressed: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Add Photo')));
              await Navigator.pushNamed(context, NewPostWidget.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Logout')));
              await instance.signOut();
              Get.offAll(const WelcomeScreen());
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
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
