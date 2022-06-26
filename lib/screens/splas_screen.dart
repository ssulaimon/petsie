import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:petsie/firebase_options.dart';
import 'package:petsie/images_name/colors/colors.dart';
import 'package:petsie/images_name/images_names.dart';
import 'package:petsie/routes/routes_names.dart';
import '../functions/dialogue.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkConnecttion() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    switch (hasConnection) {
      case true:
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        var user = FirebaseAuth.instance;
        if (user != null) {
          Navigator.of(context).popAndPushNamed(catLoverScreen);
        } else {
          Navigator.of(context).popAndPushNamed(loginScreen);
        }

        break;
      default:
        await dailogueShow(
            context: context,
            content:
                "Please connect to a mobile internet or a wifi connection. Then retry",
            title: "Internet Connection error!!!",
            function: () {
              Navigator.of(context).pop();
            });
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    checkConnecttion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              image: AssetImage(paw),
              width: 200.0,
              height: 200.0,
            ),
          ),
          const Text(
            "Pestie",
            style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 60.0,
                wordSpacing: 2.0,
                color: colorbrown),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 30.0,
              ),
              Text(
                "Care&Love",
                style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    color: colorbrown,
                    fontSize: 20.0),
              )
            ],
          )
        ],
      ),
    );
  }
}
