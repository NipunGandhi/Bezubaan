import 'package:flutter/material.dart';
import '../Widgets/postWidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String name = "/ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            padding: const EdgeInsets.only(top: 35, left: 20, bottom: 20),
            child: Row(
              children: [
                Column(
                  children: const [
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Username",
                    ),
                  ],
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text("E-Mail:"),
                    const SizedBox(height: 8),
                    const Text("Mobile No:"),
                    const SizedBox(height: 8),
                    const Text("Location:"),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () => {
                              print("Whatsapp Contact"),
                            },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: const Text("Whatsapp")),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: const [
                Text("Text"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
