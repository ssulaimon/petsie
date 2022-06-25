import 'package:flutter/material.dart';
import 'package:petsie/routes/routes_names.dart';
import 'package:petsie/screens/registration_screen.dart';
import 'package:petsie/screens/splas_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: splasScreen,
      routes: {
        splasScreen: (context) => const SplashScreen(),
        registration: (context) => const Registration(),
      },
    ),
  );
}
