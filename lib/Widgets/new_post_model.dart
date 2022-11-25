import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/Widgets/custom_avator.dart';
import 'package:untitled/models/postModel.dart';

import '../providers/currentState.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:untitled/Screens/homePageScreen.dart';

import '../providers/currentState.dart';
import '../utils/screen_loader.dart';

//Post widget template that will contain post
class NewPostWidget extends StatefulWidget {
  NewPostWidget({super.key});

  @override
  State<NewPostWidget> createState() => _NewPostWidgetState();
}

class _NewPostWidgetState extends State<NewPostWidget> {
  File? _image;

  Future getImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);
      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  final CurrentState _instance = Get.find();

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 380,
      child: Column(
        children: [
          //DP, Username and Distance
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAvatar(
                      isImageNull: _instance.currentUser.imageLink == null,
                      firstAlphabet: _instance.currentUser.userName!
                          .substring(0, 1)
                          .toUpperCase(),
                      imageUrl: _instance.currentUser.imageLink,
                      fontSize: 24,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${_instance.currentUser.userName}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "City Name",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          //For photo
          Expanded(
            child: Container(
              color: Colors.red,
              child: SizedBox(
                width: 200,
                child: _image == null
                    ? ElevatedButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.image_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Pick from Gallery"),
                          ],
                        ),
                      )
                    : Image.file(
                        _image!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          //Interaction options (Personal chat, Location, Whatsapp)
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Like button"),
                Text("Location"),
                Text("Whatsapp"),
              ],
            ),
          ),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),

          NeoPopTiltedButton(
            color: Colors.green,
            onTapUp: () async {
              if (descriptionController.text.isNotEmpty && _image != null) {
                PostModel post = PostModel(
                    creatorImage: _instance.currentUser.imageLink,
                    timeOfPost: DateTime.now(),
                    description: descriptionController.text,
                    creatorName: _instance.currentUser.name,
                    emailId: _instance.currentUser.email,
                    imageFile:_image,
                    creatorId: _instance.currentUser.uid);
                _instance.createAPost(post);
              } else {
                return;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 15,
              ),
              //child: SvgPicture.asset('assets/svg/cta_text_view.svg'),
              child: Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
