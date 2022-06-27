import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petsie/enums/interest.dart';
import 'package:petsie/functions/toast.dart';
import 'package:petsie/images_name/colors/colors.dart';
import 'package:petsie/routes/routes_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  SharedPreferences? sharedPreferences;

  void initializedSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    initializedSharedPreference();
    super.initState();
  }

  String? interest;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "What Pet are you interested in ",
            style: TextStyle(
              color: colorBlue,
            ),
          ),
          ListTile(
            leading: Radio(
                activeColor: colorBlue,
                value: "Cat",
                groupValue: interest,
                onChanged: (value) {
                  setState(() {
                    interest = value.toString();
                  });
                }),
            title: const Text('Cat'),
          ),
          ListTile(
            leading: Radio(
                activeColor: colorBlue,
                value: "Dog",
                groupValue: interest,
                onChanged: (value) {
                  setState(() {
                    interest = value.toString();
                  });
                }),
            title: const Text("Dog"),
          ),
          FlatButton(
            onPressed: () async {
              ToastContext().init(context);
              if (interest != null) {
                await sharedPreferences?.setString(
                    sharePrefrenceQuiz, interest.toString());
                String? choice =
                    sharedPreferences?.getString(sharePrefrenceQuiz);
                switch (choice) {
                  case 'Cat':
                    Navigator.of(context).popAndPushNamed(catLoverScreen);
                    break;
                  default:
                    Navigator.of(context).popAndPushNamed(dogLoverScreen);
                    break;
                }
              } else {
                showToast(message: "Erorr");
              }
            },
            color: colorBlue,
            child: const Text(
              "Continue",
              style: TextStyle(color: colorWhite),
            ),
          )
        ],
      ),
    );
  }
}
