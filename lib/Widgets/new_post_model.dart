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
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

//Post widget template that will contain post
class NewPostWidget extends StatefulWidget {
  NewPostWidget({super.key});

  static String name = '/newPostWidget';

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
    Position data;
    var number = _instance.currentUser.phone;
    var mail = _instance.currentUser.email;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 540,
          child: Column(
            children: [
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
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "${_instance.currentUser.userName}",
                          style: const TextStyle(
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
                    width: double.maxFinite,
                    child: _image == null
                        ? ElevatedButton(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.image_outlined),
                                SizedBox(
                                  width: 10,
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
              //Interaction options (Location, Mail, Whatsapp)
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Text("Location"),
                      onTap: () async {
                        data = await determinePosition();
                        String mapUrl =
                            "https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}";
                        await launch(mapUrl);
                      },
                    ),
                    GestureDetector(
                      child: const Text("WhatsApp"),
                      onTap: () async => await launch(
                          "https://wa.me/+91$number?text=I found your post on Bezubaan App and I want to help you"),
                    ),
                    GestureDetector(
                      child: const Text("Gmail"),
                      onTap: () async => await launch(
                          "mailto:$mail?subject=Want to help&body=I found your post on Bezubaan App and I want to help you"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              NeoPopTiltedButton(
                color: Colors.green,
                onTapUp: () async {
                  data = await determinePosition();
                  if (descriptionController.text.isNotEmpty && _image != null) {
                    PostModel post = PostModel(
                      creatorImage: _instance.currentUser.imageLink,
                      timeOfPost: DateTime.now(),
                      description: descriptionController.text,
                      creatorName: _instance.currentUser.name,
                      emailId: _instance.currentUser.email,
                      imageFile: _image,
                      creatorId: _instance.currentUser.uid,
                      phoneNumber: _instance.currentUser.phone,
                      latitude: data.latitude.toString(),
                      longitude: data.longitude.toString(),
                    );
                    await _instance.createAPost(post);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fill Info')));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 15,
                  ),
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
