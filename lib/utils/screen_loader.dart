import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/providers/screen_utils_controller.dart';

class ScreenLoader extends StatelessWidget {
  Widget child;

  ScreenLoader({Key? key, required this.child}) : super(key: key);

  final ScreenUtilsLoader _instance = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("the screen loader page is rebuilding");
    return Stack(
      children: [
        child,
        Obx(() => Visibility(
              visible: _instance.disableScreen.value,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Center(
                      child: Lottie.asset("assets/lottie/airplane.json")),
                ),
              ),
            ))
      ],
    );
  }
}
