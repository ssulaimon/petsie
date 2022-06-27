import 'package:flutter/material.dart';
import 'package:petsie/screens/dog_breeds.dart';
import 'package:petsie/screens/dog_fact.dart';

class DogHome extends StatefulWidget {
  const DogHome({Key? key}) : super(key: key);

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  int _selected = 0;
  List<Widget> list = const [
    DogBreedHome(),
    DogFact(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_selected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        onTap: (value) {
          setState(() {
            _selected = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "home"),
          BottomNavigationBarItem(
            label: "Do you know",
            icon: Icon(
              Icons.question_mark,
            ),
          )
        ],
      ),
    );
  }
}
