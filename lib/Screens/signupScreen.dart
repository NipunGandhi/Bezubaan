import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/photoChooser.dart';
import 'package:untitled/models/ourUser.dart';
import 'package:untitled/utils/screen_loader.dart';

import '../providers/currentState.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static String name = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _passwordVisible = true;
  final CurrentState _instance = Get.find();
  var nameController = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var userName = TextEditingController();
  var password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email ID',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phone,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: _passwordVisible,
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (phone.text.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  'Length should be 10 of phone number',
                                )),
                              );
                            } else if (password.text.length <= 8) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  'Password length should be more than or equal to 8',
                                )),
                              );
                            } else if (!email.text.contains("@") ||
                                !email.text.contains(".")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  'Email formatting is wrong',
                                )),
                              );
                            } else if (phone.text.contains("-") ||
                                phone.text.contains(".")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  'Phone number formatting is wrong',
                                )),
                              );
                            } else if (nameController.text.isNotEmpty &&
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
                              // _instance.createNewUser(model: mode, password: password.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all details')),
                              );
                            }
                          },
                          child: const Text("Next"),
                        ),
                      ],
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
