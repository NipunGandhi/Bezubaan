import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';
import 'package:untitled/utils/screen_loader.dart';
import '../Widgets/bottomBarWidget.dart';
import '../providers/currentState.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String name = '/loginScreen';
  final CurrentState instance = Get.find();

  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bezubaan",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 45),
                    //
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 10),
                    //
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 10),
                    //
                    ElevatedButton(
                      onPressed: () async {
                        await instance.loginUser(email.text, password.text);

                        // Navigator.pushReplacementNamed(
                        //     context, HomePageScreen.name);
                      },
                      child: const Text("Login"),
                    ),
                    //
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Forget your login details?"),
                          TextButton(
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, ForgetPasswordScreen.name);
                            },
                            child: const Text("Contact us"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomBar(
              buttonText: "Sign up",
              text: "Don't have an account?",
              page: SignUpScreen.name,
            ),
          ],
        ),
      ),
    );
  }
}
