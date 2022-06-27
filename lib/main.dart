import 'package:flutter/material.dart';
import 'package:petsie/routes/routes_names.dart';
import 'package:petsie/screens/dog_home.dart';
import 'package:petsie/screens/home_screen_cat.dart';
import 'package:petsie/screens/password_reset.dart';
import 'package:petsie/screens/login_screen.dart';
import 'package:petsie/screens/quiz_screen.dart';
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
        loginScreen: (context) => const LoginScreen(),
        verifyEmail: (context) => const PasswordReset(),
        quiz: (context) => const Quiz(),
        catLoverScreen: (context) => const HomeCatLover(),
        dogLoverScreen: (context) => const DogHome(),
      },
    ),
  );
}
