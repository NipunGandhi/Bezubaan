import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String name = '/loginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Center(child: null),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Bezubaan",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 45),
                  //
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  SizedBox(height: 10),
                  //
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 10),
                  //
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Login"),
                  ),
                  SizedBox(height: 10),
                  //
                  Text("Forget your login details? Contact us"),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text("Don't have an account? Sign up"),
            ),
          ),
        ],
      ),
    );
  }
}
