import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsie/functions/dialogue.dart';
import 'package:petsie/functions/toast.dart';
import 'package:petsie/routes/routes_names.dart';

import '../images_name/colors/colors.dart';
import '../images_name/images_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Login",
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
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      try {
                        var user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (user.user?.emailVerified == false) {
                          dailogueShow(
                              context: context,
                              content: "Re-send your verification link",
                              title: "Email verify",
                              function: () {
                                Navigator.of(context)
                                    .popUntil((route) => false);
                              },
                              sendCode: () async {
                                await user.user
                                    ?.sendEmailVerification()
                                    .whenComplete(
                                      () => showToast(
                                          message: "Email verification sent"),
                                    );
                              });
                        } else {
                          log("good to go");
                        }
                      } on FirebaseAuthException catch (erorr) {
                        log(erorr.code);
                      }
                    },
                    child: const Text(
                      "Login",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(registration);
                      },
                      child: const Text(
                        "Create account",
                        style: TextStyle(
                          color: colorBlue,
                        ),
                      ),
                    ),
                    const Text("|"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(verifyEmail);
                        },
                        child: const Text(
                          "Email verification",
                          style: TextStyle(
                            color: colorBlue,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
