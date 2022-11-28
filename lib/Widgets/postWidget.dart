import 'package:flutter/material.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/Widgets/custom_avator.dart';
import 'package:get/get.dart';

//Post widget template that will contain post
class PostWidget extends StatelessWidget {
  final String mail;
  final String username;
  final String creatorImage;
  final String postImage;
  final String phoneNumber;
  final String latitude;
  final String longitude;

  const PostWidget({
    super.key,
    required this.mail,
    required this.username,
    required this.creatorImage,
    required this.postImage,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 500,
      child: Column(
        children: [
          //DP, Username and Distance
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAvatar(
                      isImageNull: creatorImage == null,
                      imageUrl: creatorImage,
                      fontSize: 15,
                      firstAlphabet: username.substring(0, 1).toUpperCase(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          ProfileScreen(
                            email: mail,
                            username: username,
                            creatorImage: creatorImage,
                            phoneNumber: phoneNumber,
                          ),
                        );
                      },
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "City Name",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          //For photo
          Expanded(
            child: Image.network(
              postImage,
              width: double.maxFinite,
            ),
          ),
          //Interaction options (Personal chat, Location, Whatsapp)
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: const Text("Location"),
                  onTap: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Longitude - $longitude && latitude - $latitude'),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: const Text("WhatsApp"),
                  onTap: () async => await launch(
                      "https://wa.me/+91$phoneNumber?text=I found your post on Bezubaan App and I want to help you"),
                ),
                GestureDetector(
                  child: const Text("Gmail"),
                  onTap: () async => await launch(
                      "mailto:$mail?subject=Want to help&body=I found your post on Bezubaan App and I want to help you"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
