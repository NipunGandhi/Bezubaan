import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/Widgets/locationDataCustom.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'package:untitled/models/postModel.dart';
import 'package:untitled/providers/currentState.dart';
import '../Widgets/postWidget.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/location_service.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);
  static String name = "/HomePageScreen";

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final CurrentState instance = Get.find();
  List snaps = [];
  late Position data;
  bool loading = true;

  newMethod() async {
    data = await determinePosition();
    snaps = await getData(data.latitude, data.longitude);
    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    newMethod();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bezubaan"),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile Page',
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile Page')));
                Get.to(
                  ProfileScreen(
                    email: instance.currentUser.email.toString(),
                    username: instance.currentUser.userName.toString(),
                    creatorImage: instance.currentUser.imageLink.toString(),
                    phoneNumber: instance.currentUser.phone.toString(),
                    button: true,
                    userID: instance.currentUser.uid.toString(),
                  ),
                );
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
        body: loading == false
            ? ListView.builder(
                itemCount: snaps.length,
                itemBuilder: (context, index) {
                  if (snaps[index]["creatorId"].toString() ==
                      instance.currentUser.uid.toString()) {
                    return Container();
                  } else {
                    return PostWidget(
                      mail: snaps[index]["emailId"],
                      username: snaps[index]["creatorName"],
                      creatorImage: snaps[index]["creatorImage"],
                      postImage: snaps[index]["imageUrl"],
                      phoneNumber: snaps[index]["phoneNumber"],
                      latitude: snaps[index]["latitude"],
                      longitude: snaps[index]["longitude"],
                      description: snaps[index]["description"],
                      uid: snaps[index]["creatorId"].toString(),
                    );
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
                heightFactor: 50,
              ),
      ),
    );
  }
}
