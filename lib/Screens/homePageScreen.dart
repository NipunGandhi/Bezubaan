import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:untitled/Screens/splashScreen.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'package:untitled/models/postModel.dart';
import 'package:untitled/providers/currentState.dart';
import '../Widgets/postWidget.dart';
import 'dart:async';
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

  final Stream<int> _bids = (() {
    late final StreamController<int> controller;
    controller = StreamController<int>(
      onListen: () async {
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(1);
        await Future<void>.delayed(const Duration(seconds: 1));
        await controller.close();
      },
    );
    return controller.stream;
  })();

  var snaps;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


     ///  gandhi bhaiya this is the code that is responsible for fetching
    ///  the data from the firestore database and automatically returns the
    ///  data in the postmodel instance which we can consume using the firestoreListview
    ///  package
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
      // body: StreamBuilder<int>(
      //   stream: _bids,
      //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      //     List<Widget> children;
      //     if (snapshot.hasError) {
      //       children = <Widget>[
      //         const Icon(
      //           Icons.error_outline,
      //           color: Colors.red,
      //           size: 60,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 16),
      //           child: Text('Error: ${snapshot.error}'),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 8),
      //           child: Text('Stack trace: ${snapshot.stackTrace}'),
      //         ),
      //       ];
      //     } else {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //           children = const <Widget>[
      //             Icon(
      //               Icons.info,
      //               color: Colors.blue,
      //               size: 60,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(top: 16),
      //               child: Text('Select a lot'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.waiting:
      //           children = const <Widget>[
      //             SizedBox(
      //               width: 60,
      //               height: 60,
      //               child: CircularProgressIndicator(),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(top: 16),
      //               child: Text('Awaiting bids...'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.active:
      //           children = <Widget>[
      //             const Icon(
      //               Icons.check_circle_outline,
      //               color: Colors.green,
      //               size: 60,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 16),
      //               child: Text('\$${snapshot.data}'),
      //             ),
      //           ];
      //           break;
      //         case ConnectionState.done:
      //           children = <Widget>[
      //             const Icon(
      //               Icons.info,
      //               color: Colors.blue,
      //               size: 60,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 16),
      //               child: Text('\$${snapshot.data} (closed)'),
      //             ),
      //           ];
      //           break;
      //       }
      //     }
      //
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: children,
      //     );
      //   },
      // ),

      body : FirestoreListView<PostModel>(
        query: snaps,
        itemBuilder: (context,snapshot) {

          // this post contain all the data of a single post fetched one at a time
          // here you can add if conditions that if the uid of the post matches your local
          // one then dont show that poist
          final post = snapshot.data();
          if(post.creatorId ==  instance.currentUser.uid) {
            return Container();
          }
          return Container(
            child:Text(post.emailId!)
          );
        },
      )
    );
  }
}
