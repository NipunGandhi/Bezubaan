import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:untitled/models/ourUser.dart';
import 'package:untitled/models/postModel.dart';
import 'package:untitled/providers/currentState.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user, File image) async {
    String retVal = "error";

    try {
      /// code to upload an image
      late String randomGroupName;
      var intValue = Random().nextInt(10000000);
      randomGroupName = intValue.toString();
      var snapshot = await FirebaseStorage.instance
          .ref("users/$randomGroupName")
          .putFile(File(image.path ?? ""));
      String rep = await snapshot.ref.getDownloadURL();
      user.imageLink = rep;
      user.filePath = "users/$randomGroupName";
      await _firestore.collection('users').doc(user.uid).set(user.toJson());
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      // this block is running fine
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      print("Above the document snapshot data");
      print(_docSnapshot.data());
      print("below the document snapshot data");
      //retVal(_docSnapshot.data()['name']);

      Map<String, dynamic>? data = _docSnapshot.data() as Map<String, dynamic>?;
      retVal = OurUser.fromJson(_docSnapshot.data() as Map<String, dynamic>);

      print("Exiting the get user information function now");
    } catch (e) {
      print("in the catch of the get user info");
      print(e);
    }
    return retVal;
  }

  Future<String> createAPost(PostModel postModel) async {
    String retVal = "error";
    try {
      CurrentState _instance = Get.find();
      late String randomGroupName;
      var intValue = Random().nextInt(10000000);
      randomGroupName = intValue.toString();
      var snapshot = await FirebaseStorage.instance
          .ref("${_instance.currentUser.uid}/$randomGroupName")
          .putFile(File(postModel.imageFile?.path ?? ""));
      String rep = await snapshot.ref.getDownloadURL();
      postModel.imageUrl = rep;

      await _firestore.collection("posts").doc().set(postModel.toJson());
      retVal = "success";
    }catch(e) {
      print(e);

    }

    return retVal;
  }
}
