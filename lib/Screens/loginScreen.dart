import 'package:flutter/material.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';
import '../Widgets/bottomBarWidget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String name = '/loginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 10),
                  //
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 10),
                  //
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, HomePageScreen.name);
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
                          onPressed: () {
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
    );
  }
}
