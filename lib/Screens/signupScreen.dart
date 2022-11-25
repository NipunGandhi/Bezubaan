import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/photoChooser.dart';
import 'package:untitled/models/ourUser.dart';
import 'package:untitled/utils/screen_loader.dart';

import '../providers/currentState.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static String name = '/signUpScreen';

  final CurrentState _instance = Get.find();
  var nameController = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var userName = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Full Name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: userName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email ID',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            phone.text.isNotEmpty &&
                            userName.text.isNotEmpty &&
                            password.text.isNotEmpty) {
                          OurUser mode = OurUser(
                              userName: userName.text,
                              phone: phone.text,
                              description: "",
                              name: nameController.text,
                              email: email.text);

                          _instance.password = password.text;
                          _instance.currentUser = mode;
                          Get.to(() => const PhotoChooser());
                          //_instance.createNewUser(model: mode, password: password.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all details')),
                          );
                        }
                        // Future.delayed(
                        //   const Duration(seconds: 1),
                        //   () => Navigator.pushNamed(context, PhotoChooser.name),
                        // );
                      },
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
