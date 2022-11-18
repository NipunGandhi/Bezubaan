import 'package:flutter/material.dart';
import '../Widgets/CircleWidget.dart';
import '../Widgets/PostWidget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  static String name = '/homePageScreen';

  @override
  Widget build(BuildContext context) {
    double pHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: (pHeight / 10.5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const <Widget>[
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
                CircleWidgets(),
              ],
            ),
          ),
          const PostWidget(),
          const PostWidget(),
          const PostWidget(),
          const PostWidget(),
          const PostWidget(),
        ],
      ),
    );
  }
}
