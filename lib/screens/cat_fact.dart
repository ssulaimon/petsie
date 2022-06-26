import 'package:flutter/material.dart';

class CatFact extends StatefulWidget {
  const CatFact({Key? key}) : super(key: key);

  @override
  State<CatFact> createState() => _CatFactState();
}

class _CatFactState extends State<CatFact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
