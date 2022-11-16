import 'package:flutter/material.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
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
                      print("Login Button");
                    },
                    child: Text("Login"),
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
                            print("Contact Us Page");
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
          Container(
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.name);
                    print("Sign Up Page");
                  },
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
