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

class PhotoChooser extends StatefulWidget {
  const PhotoChooser({Key? key}) : super(key: key);
  static String name = '/PhotoChooser';

  @override
  State<PhotoChooser> createState() => _PhotoChooserState();
}

class _PhotoChooserState extends State<PhotoChooser> {
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

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Photo"),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _image != null
                  ? Image.file(
                      _image!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://www.pngfind.com/pngs/m/110-1102775_download-empty-profile-hd-png-download.png",
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Pick from Camera"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
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
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_image != null) {
                      await _instance.createNewUser(
                          model: _instance.currentUser, image: _image!);
                    }
                    //Navigator.pushReplacementNamed(context, HomePageScreen.name);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.done),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Submit profile"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
