import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:pizza_app/model/userModel.dart';
import 'package:pizza_app/utils/authRepo.dart';

class UserProfile {
  Future<UserModel?> getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      final datas = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user!.uid)
          .get();

      if (datas.docs.isNotEmpty) {
        return UserModel.fromJson(datas.docs.first.data());
      } else {
        print('No user found');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateUser(UserModel userModel, BuildContext context) async {
    try {
      print(userModel.toJson());
      File file = File(userModel.profile);
      if (file.existsSync()) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('${DateTime.now().millisecondsSinceEpoch.toString()}');
        firebase_storage.UploadTask uploadTask = ref.putFile(file);
        await uploadTask;
        String downloadURL = await ref.getDownloadURL();
        userModel.profile = downloadURL;
      } else {
        print('File does not exist at path: ${userModel.profile}');
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.toJson());
      print(userModel.toJson());
      Navigator.pop(context);
    } catch (e) {
      print('Error updating agency: $e');
      throw e;
    }
  }
}
