import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/consts/firebase_const.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profielImageLink = '';

  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImg() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentuser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profielImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentuser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentuser!.reauthenticateWithCredential(cred).then((value) {
      currentuser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
