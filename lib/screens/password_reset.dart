import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petsie/functions/dialogue.dart';

import '../images_name/colors/colors.dart';
import '../images_name/images_names.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  late TextEditingController _email;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
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
                    "Send Reset link",
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
                      try {
                        var user = await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _email.text)
                            .whenComplete(() => dailogueShow(
                                context: context,
                                content: "Reset Link sent",
                                title: "Reset Passord",
                                function: () {
                                  Navigator.of(context).pop();
                                }));
                      } on FirebaseAuthException catch (erorr) {}
                    },
                    child: const Text(
                      "Send link",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
