import 'package:flutter/material.dart';
import 'package:petsie/images_name/colors/colors.dart';

import 'package:petsie/screens/cat_fact.dart';
import 'package:petsie/screens/cat_home.dart';

class HomeCatLover extends StatefulWidget {
  const HomeCatLover({Key? key}) : super(key: key);

  @override
  State<HomeCatLover> createState() => _HomeCatLoverState();
}

class _HomeCatLoverState extends State<HomeCatLover> {
  int _selected = 0;
  List<Widget> body = [
    const CatHome(),
    const CatFact(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_selected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorGrey,
        selectedItemColor: colorWhite,
        unselectedItemColor: colorBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Do you know',
          )
        ],
        currentIndex: _selected,
        onTap: (value) {
          setState(() {
            _selected = value;
          });
        },
      ),
    );
  }
}
