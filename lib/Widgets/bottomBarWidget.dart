import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  String text;
  String page;
  String buttonText;

  BottomBar({
    required this.buttonText,
    required this.page,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(text),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, page);
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
