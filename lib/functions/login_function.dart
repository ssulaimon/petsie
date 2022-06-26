import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsie/functions/dialogue.dart';
import 'package:petsie/functions/toast.dart';
import 'package:petsie/routes/routes_names.dart';
import 'package:toast/toast.dart';

void login(
    {required BuildContext context,
    required String email,
    required String password}) async {
  ToastContext().init(context);

  try {
    var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (user.user?.emailVerified == false) {
      dailogueShow(
        context: context,
        content:
            "Your account is not verified. Email verfication have been sent again. Check your email",
        title: "Email verify",
        function: () {
          Navigator.pop(context);
        },
      );
    } else {
      Navigator.of(context).popAndPushNamed(quiz);
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'user-not-found':
        showToast(message: "user-not-found ");
        break;
      case 'wrong-password':
        showToast(message: "wrong-password");
        break;
      case 'invalid-email':
        showToast(message: 'invalid-email');
        break;
      default:
        showToast(message: "wrong-password");
        break;
    }
  }
}
