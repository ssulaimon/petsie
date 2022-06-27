import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petsie/images_name/colors/colors.dart';

class DogFact extends StatefulWidget {
  const DogFact({Key? key}) : super(key: key);

  @override
  State<DogFact> createState() => _DogFactState();
}

late String fact;
Future<void> catFactapi() async {
  var uri = Uri.parse(
      'https://dog-fact-api.herokuapp.com/api/v1/resources/dogs?number=1');
  // Map<String, String> header = {
  //   'X-RapidAPI-Key': '7bc9f390d3msh22d9698290555c5p1d962ejsn7e39abbb49ad'
  // };
  Response response = await get(
    uri,
  );
  List decode = jsonDecode(response.body);
  fact = decode[0]['fact'];
}

class _DogFactState extends State<DogFact> {
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
