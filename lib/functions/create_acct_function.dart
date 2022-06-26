import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsie/functions/dialogue.dart';
import 'package:petsie/functions/toast.dart';
import 'package:toast/toast.dart';

void createNewaUser(
    {required String email,
    required String password,
    required BuildContext context,
    required String name}) async {
  ToastContext().init(context);
  try {
    final userProfile =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userProfile.user?.updateDisplayName(name);
    await userProfile.user?.sendEmailVerification().whenComplete(() =>
        dailogueShow(
            context: context,
            content:
                "Check your email to verify your account. In some cases check your spam box",
            title: "Email verify",
            function: () {
              Navigator.pop(context);
            }));
  } on FirebaseException catch (eror) {
    switch (eror.code) {
      case "weak-password":
        showToast(
          message: "Weak password",
        );
        log("");
        break;
      case "invalid-email":
        showToast(message: "invalid-email");
        break;
      case ('email-already-in-use'):
        showToast(
          message: "email-already-in-use",
        );
        break;
      default:
        showToast(
          message: eror.code.toString(),
        );
    }
  }
}
