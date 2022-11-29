import 'package:flutter/material.dart';
import 'package:untitled/Screens/profileScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/Widgets/custom_avator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

//Post widget template that will contain post
class PostWidget extends StatefulWidget {
  final String mail;
  final String username;
  final String creatorImage;
  final String postImage;
  final String phoneNumber;
  final String latitude;
  final String longitude;
  final String description;
  final String uid;

  const PostWidget({
    super.key,
    required this.mail,
    required this.username,
    required this.creatorImage,
    required this.postImage,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.uid,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  var a = "City Name";

  findCity() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      double.parse(widget.latitude),
      double.parse(widget.longitude),
    );
    setState(() {
      a = "${placemarks[0].locality}, ${placemarks[0].administrativeArea}";
    });
  }

  @override
  void initState() {
    super.initState();
    findCity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      isImageNull: widget.creatorImage == null,
                      imageUrl: widget.creatorImage,
                      fontSize: 15,
                      firstAlphabet:
                          widget.username.substring(0, 1).toUpperCase(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          ProfileScreen(
                            email: widget.mail,
                            username: widget.username,
                            creatorImage: widget.creatorImage,
                            phoneNumber: widget.phoneNumber,
                            userID: widget.uid,
                          ),
                        );
                      },
                      child: Text(
                        widget.username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  a,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          //For photo
          Expanded(
            child: Image.network(
              widget.postImage,
              fit: BoxFit.cover,
              width: double.infinity,
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
                  // onTap: () async {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //           'Longitude - ${widget.longitude} && latitude - ${widget.latitude}'),
                  //     ),
                  //   );
                  // },
                  onTap: () async {
                    String mapUrl =
                        "https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}";
                    await launch(mapUrl);
                  },
                ),
                GestureDetector(
                  child: const Text("WhatsApp"),
                  onTap: () async => await launch(
                      "https://wa.me/+91${widget.phoneNumber}?text=I found your post on Bezubaan App and I want to help you"),
                ),
                GestureDetector(
                  child: const Text("Gmail"),
                  onTap: () async => await launch(
                      "mailto:${widget.mail}?subject=Want to help&body=I found your post on Bezubaan App and I want to help you"),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Description: ${widget.description}",
            ),
          ),
        ],
      ),
    );
  }
}
