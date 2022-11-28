import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Screens/forgetPasswordScreen.dart';
import 'package:untitled/Screens/signupScreen.dart';
import 'package:untitled/utils/screen_loader.dart';
import '../Widgets/bottomBarWidget.dart';
import '../providers/currentState.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String name = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CurrentState instance = Get.find();
  var email = TextEditingController();
  var password = TextEditingController();
  var _passwordVisible = true;

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
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: password,
                      obscureText: _passwordVisible,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    IconButton(
                      icon: Icon(
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
                    //
                    ElevatedButton(
                      onPressed: () async {
                        await instance.loginUser(email.text, password.text);
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
