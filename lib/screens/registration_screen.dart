// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:petsie/functions/toast.dart';

import 'package:petsie/images_name/colors/colors.dart';
import 'package:petsie/images_name/images_names.dart';
import 'package:toast/toast.dart';

import '../functions/dialogue.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

late TextEditingController name;
late TextEditingController _email;
late TextEditingController _password;

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Image(
                    image: AssetImage(paw),
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: colorCream,
                      fontFamily: 'PoppinsMedium',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text("Name"),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    fillColor: colorGrey,
                    focusColor: colorGrey,
                    hintText: "Name",
                    filled: true,
                    focusedBorder: InputBorder.none,
                    hoverColor: colorGrey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: colorGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text("Email"),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    fillColor: colorGrey,
                    focusColor: colorGrey,
                    hintText: "Email",
                    filled: true,
                    focusedBorder: InputBorder.none,
                    hoverColor: colorGrey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: colorGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text("Password"),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: colorGrey,
                    focusColor: colorGrey,
                    hintText: "Password",
                    filled: true,
                    focusedBorder: InputBorder.none,
                    hoverColor: colorGrey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: colorGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: colorBlue,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 30.0,
                      ),
                    ),
                    onPressed: () {
                      createNewaUser(
                          email: _email.text,
                          password: _password.text,
                          context: context);
                    },
                    child: const Text(
                      "Create account",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Center(
                  child: Text(
                    "or",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Center(
                  child: SignInButton(Buttons.Google, onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void createNewaUser(
    {required String email,
    required String password,
    required BuildContext context}) async {
  try {
    final userProfile =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userProfile.user?.updateDisplayName(name.text);
    await userProfile.user?.sendEmailVerification().whenComplete(() =>
        dailogueShow(
            context: context,
            content:
                "Check your email to verify your account. In some cases check your spam box",
            title: "Email verify",
            function: () {
              Navigator.of(context).pop();
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
