import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petsie/images_name/colors/colors.dart';

class CatFact extends StatefulWidget {
  const CatFact({Key? key}) : super(key: key);

  @override
  State<CatFact> createState() => _CatFactState();
}

late String fact;
Future<void> catFactapi() async {
  var uri = Uri.parse('https://catfact.ninja/fact?max_length=600');
  // Map<String, String> header = {
  //   'X-RapidAPI-Key': '7bc9f390d3msh22d9698290555c5p1d962ejsn7e39abbb49ad'
  // };
  Response response = await get(
    uri,
  );
  Map decode = jsonDecode(response.body);
  fact = decode['fact'];
}

class _CatFactState extends State<CatFact> {
  @override
  void initState() {
    // TODO: implement initState
    catFactapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCream,
      body: FutureBuilder(
        future: catFactapi(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(fact),
                ),
              );
              break;
            default:
              return const Center(
                child: Text('Loading'),
              );
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGrey,
        onPressed: () {
          setState(() {
            catFactapi();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
