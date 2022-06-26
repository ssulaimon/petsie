import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsie/functions/dialogue.dart';
import 'package:petsie/functions/toast.dart';
import 'package:toast/toast.dart';

void resetPassword(
    {required BuildContext context, required String email}) async {
  try {
    ToastContext().init(context);
    var user = await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    dailogueShow(
      context: context,
      content: "Your password reset link have been sent. Check your email",
      title: "Reset Passord",
      function: () {
        Navigator.pop(context);
      },
    );
  } on FirebaseAuthException catch (erorr) {
    switch (erorr.code) {
      case 'user-not-found':
        showToast(message: 'user-not-found');

        break;
      case 'invalid-email':
        showToast(message: 'invalid-email');

        break;
      default:
        // showToast(message: erorr.code.toString());
        log(erorr.code);
        break;
    }
  }
}
