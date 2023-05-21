import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier {
  // File? imagePick;
  late User? _user;
  late StreamSubscription<User?> _userSubscription;

  // final picker = ImagePicker();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Future<void> pickImage(context) async {
  //   notifyListeners();
  //   final pickedFile = await picker.pickImage(
  //       source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);
  //   imagePick = File(pickedFile!.path);
  //   notifyListeners();
  // }

  DataProvider() {
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final controllerTitle = TextEditingController();
  final controllerDeskription = TextEditingController();
  final controllerPrice = TextEditingController();
  Future<void> uploadData(context) async {
    if (formkey.currentState!.validate() && _user != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(DateTime.now().toString() + ".jpg");
      // UploadTask uploadTask = ref.putFile(imagePick!);
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      // String imageUrl = await taskSnapshot.ref.getDownloadURL();

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference content = firestore.collection('content');

      await content.add({
        'title': controllerTitle.text,
        'description': controllerDeskription.text,
        'price': controllerPrice.text,
        'userId': _user!.uid,
      });

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Gagal mengupload data'),
        ),
      );
    }
  }
}
