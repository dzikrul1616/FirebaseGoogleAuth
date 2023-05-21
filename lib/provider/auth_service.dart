import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginbloc/models/user.dart';

class AuthService extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(context) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      return _userFromFirebase(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(context) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    if (result.user != null) {
      await _firestore.collection("users").doc(result.user!.uid).set({
        "email": emailController.text,
        "userId": result.user!.uid,
      });
    }
    return _userFromFirebase(result.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final result = await _firebaseAuth.signInWithCredential(credential);
      if (result.user != null) {
        await _firestore.collection("users").doc(result.user!.uid).set({
          "email": result.user!.email,
          "userId": result.user!.uid,
        });
      }
      return _userFromFirebase(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  showAlertDialog(BuildContext context, String id) {
    Widget cancelButton = TextButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Ya"),
      onPressed: () async {
        await FirebaseFirestore.instance.collection('content').doc(id).delete();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Hapus content"),
      content: Text("Apakah anda yakin ingin menghapus content ini?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
