import 'package:flutter/material.dart';
import 'package:untitled/Widgets/new_post_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

//Post widget template that will contain post
class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String mail = "ngandhi50_be21@thapar.edu";
    String number = "+916280204417";
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 380,
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
                    const CircleAvatar(
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NewPostWidget.name);
                      },
                      child: const Text(
                        "Username",
                        style: TextStyle(
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
            child: Container(
              color: Colors.red,
            ),
          ),
          //Interaction options (Personal chat, Location, Whatsapp)
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Location"),
                GestureDetector(
                  child: const Text("WhatsApp"),
                  onTap: () async => await launch(
                      "https://wa.me/$number?text=I found your post on Bezubaan App and I want to help you"),
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
