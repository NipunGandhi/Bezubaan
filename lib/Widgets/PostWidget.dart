import 'package:flutter/material.dart';

//Post widget template that will contain post
class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: const [
                    CircleAvatar(
                      radius: 15,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
              children: const [
                Text("Like button"),
                Text("Location"),
                Text("Whatsapp"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
