import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:untitled/Screens/homePageScreen.dart';
import 'package:untitled/providers/screen_utils_controller.dart';
import '../Screens/loginScreen.dart';
import '../models/ourUser.dart';
import '../services/our_database.dart';

class CurrentState extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  OurUser currentUser = OurUser();
  late Box userBox;

  onStartup() async {
    userBox = await Hive.openBox("userDetails");
    //await signOut();

    OurUser? currentUser2;
    currentUser2 = await userBox.get("data");

    if (currentUser2 != null) {
      currentUser = currentUser2!;
    }
    // Navigate to the first screen of the application
    if (currentUser2 == null) {
      //Get.offAll(SignUpScreen());
      return;
    } else if (currentUser2.uid != null) {
      Get.offAll(HomePageScreen());
    }
  }

  Future<String> loginUser(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        retVal = "success";

        currentUser = await OurDatabase().getUserInfo(result.user?.uid ?? "");
        if (currentUser.uid == "thisisthat") {}

        userBox.put("data", currentUser);
        Get.offAll(HomePageScreen());
        // currentUser.email = result.user?.email;
        // currentUser.uid = result.user?.displayName;
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message ?? "something went wrong";
      print(e.toString());
    }
    return retVal;
  }

  late String password;

  Future<String> createNewUser({
    required OurUser model,
    required File image,
  }) async {
    String retVal = "error";
    try {
      screenLoader(true);
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: model.email!, password: password);

      if (result.user != null) {
        User? user = result.user;
        currentUser = model;

        currentUser.uid = user?.uid;
        retVal = await OurDatabase().createUser(currentUser, image);

        if (retVal == "success") {
          userBox.put("data", currentUser);
          Get.offAll(() => LoginScreen());
        }
        screenLoader(false);
      }

      // await DatabaseManager().getUsersList(user.uid);

    } on FirebaseAuthException catch (e) {
      retVal = e.message ?? "something went wrong";
      screenLoader(false);
    }

    return retVal;
  }

  screenLoader(bool change) async {
    ScreenUtilsLoader utils = Get.find();
    utils.disableScreen.value = change;
  }

  // this is the function to sign out of the application
  Future signOut() async {
    try {
      await _auth.signOut();
      await userBox.delete("data");
      currentUser = OurUser();
      return;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
