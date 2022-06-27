import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petsie/images_name/colors/colors.dart';
import 'package:petsie/routes/routes_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatHome extends StatefulWidget {
  const CatHome({Key? key}) : super(key: key);

  @override
  State<CatHome> createState() => _CatHomeState();
}

class _CatHomeState extends State<CatHome> {
  late List map;
  Future<void> apitest() async {
    var uri = Uri.parse('https://api.thecatapi.com/v1/breeds');
    Map<String, String> header = {
      'x-api-key': 'd70e69ad-6c83-441b-8897-cb6413a9c211'
    };
    Response api = await get(uri, headers: header);
    switch (api.statusCode) {
      case 200:
        map = jsonDecode(api.body);

        break;
      default:
        log(api.statusCode.toString());
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apitest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey,
      appBar: AppBar(
        title: const Text('Cat Breeds'),
        backgroundColor: colorGrey,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              var user = await FirebaseAuth.instance;
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.remove(sharePrefrenceQuiz);
              user.signOut();
              Navigator.popAndPushNamed(context, loginScreen);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image(
                      image: NetworkImage(
                        map[index]['image']['url'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: 15,
              );
              break;
            default:
              return const Center(
                child: Text("Loading.."),
              );
              break;
          }
        },
        future: apitest(),
      ),
    );
  }
}
