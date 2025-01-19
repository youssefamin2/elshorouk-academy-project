import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univerisity_system/screens/loginScreen/loginScreen.dart';

Future<void> signOut(BuildContext context)
async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
}

