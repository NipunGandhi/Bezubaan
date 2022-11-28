import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'package:untitled/models/postModel.dart';
import 'package:untitled/providers/currentState.dart';
import '../Widgets/postWidget.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);
  static String name = "/HomePageScreen";

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final CurrentState instance = Get.find();

  var snaps;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    snaps = FirebaseFirestore.instance
        .collection("posts")
        .orderBy('timeOfPost', descending: true)
        .withConverter<PostModel>(
            fromFirestore: (snapshot, _) => PostModel.fromJson(
                  snapshot.data()!,
                ),
            toFirestore: (user, _) => user.toJson());
  }

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
              Get.to(
                ProfileScreen(
                  email: instance.currentUser.email.toString(),
                  username: instance.currentUser.userName.toString(),
                  creatorImage: instance.currentUser.imageLink.toString(),
                  phoneNumber: instance.currentUser.phone.toString(),
                  button: true,
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
      body: FirestoreListView<PostModel>(
        query: snaps,
        itemBuilder: (context, snapshot) {
          final post = snapshot.data();
          if (post.creatorId == instance.currentUser.uid) {
            return Container();
          }
          return PostWidget(
            mail: post.emailId.toString(),
            username: post.creatorName.toString(),
            creatorImage: post.creatorImage.toString(),
            postImage: post.imageUrl.toString(),
            phoneNumber: post.phoneNumber.toString(),
          );
        },
      ),
    );
  }
}
