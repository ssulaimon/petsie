import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petsie/images_name/colors/colors.dart';
import 'package:petsie/routes/routes_names.dart';

class DogBreedHome extends StatefulWidget {
  const DogBreedHome({Key? key}) : super(key: key);

  @override
  State<DogBreedHome> createState() => _DogBreedHomeState();
}

class _DogBreedHomeState extends State<DogBreedHome> {
  late List map;
  Future<void> apitest() async {
    var uri = Uri.parse('https://api.thedogapi.com/v1/breeds');
    Map<String, String> header = {
      'x-api-key': 'ec95c0fd-da6a-4f02-8f3f-fd4f8aafa8eb'
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
        title: const Text('Dog Breeds'),
        backgroundColor: colorGrey,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () async {
              var user = await FirebaseAuth.instance;
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
                itemCount: map.length,
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
