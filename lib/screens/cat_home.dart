import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petsie/routes/routes_names.dart';

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
        log(map.length.toString());
        log(map[0]['url'].toString());
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
      appBar: AppBar(
        title: const Text('Cat Breeds'),
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
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, index) {
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(
                              map[index]['image']['url'] ??
                                  const Text("Loadind"),
                            ),
                          ),
                          const Text('Breed')
                        ],
                      ));
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
