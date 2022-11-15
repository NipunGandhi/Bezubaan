import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/Screens/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Welcome banner
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Help the animals near you",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          //Contains Lottie File
          Expanded(
            child: Container(
              child: Lottie.asset(
                'assets/animations/pets.json',
              ),
            ),
          ),
          //Contains Login and Register buttons
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: SwipeableButtonView(
                      isFinished: isFinished,
                      onWaitingProcess: () {
                        Future.delayed(
                          const Duration(milliseconds: 500),
                          () {
                            setState(() {
                              isFinished = true;
                            });
                          },
                        );
                      },
                      activeColor: Colors.black,
                      buttonWidget: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      buttonText: "Let's go",
                      onFinish: () async {
                        await Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.name,
                        );
                        setState(() {
                          isFinished = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
