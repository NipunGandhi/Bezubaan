import 'package:flutter/material.dart';

class CircleWidgets extends StatelessWidget {
  const CircleWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height / 9.5,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
