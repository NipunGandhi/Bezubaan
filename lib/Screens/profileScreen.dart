import 'package:flutter/material.dart';
import '../Widgets/postWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/models/postModel.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = "/ProfileScreen";

  const ProfileScreen({
    Key? key,
    required this.email,
    required this.username,
    required this.creatorImage,
    required this.phoneNumber,
    this.button = false,
    required this.userID,
  }) : super(key: key);
  final String email;
  final String userID;
  final String username;
  final String creatorImage;
  final String phoneNumber;
  final bool button;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var snaps;
  var name = "";
  var bioDescription;

  findDescription() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var a = await _firestore.collection('users').doc(widget.userID).get();
    var b = a.data() as Map<String, dynamic>;
    setState(() {
      bioDescription = b["description"];
    });
  }

  @override
  void initState() {
    super.initState();
    findDescription();
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(widget.creatorImage),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.username,
                      ),
                    ],
                  ),
                  const SizedBox(width: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text("E-Mail: ${widget.email}"),
                      const SizedBox(height: 8),
                      Text("Mobile No: ${widget.phoneNumber}"),
                      const SizedBox(height: 8),
                      Text("Description: $bioDescription"),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () async => await launch(
                                  "https://wa.me/+91${widget.phoneNumber}?text=Hello"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: const Text("Whatsapp"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () async => await launch(
                                  "mailto:${widget.email}?subject=Want to help&body=I saw your profile on bezubaan app want to contact"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                              ),
                              child: const Text("Email"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FirestoreListView<PostModel>(
                query: snaps,
                itemBuilder: (context, snapshot) {
                  final post = snapshot.data();
                  if (post.emailId.toString() == widget.email) {
                    return PostWidget(
                      mail: post.emailId.toString(),
                      username: post.creatorName.toString(),
                      creatorImage: post.creatorImage.toString(),
                      postImage: post.imageUrl.toString(),
                      phoneNumber: post.phoneNumber.toString(),
                      latitude: post.latitude.toString(),
                      longitude: post.longitude.toString(),
                      description: post.description.toString(),
                      uid: widget.userID,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
