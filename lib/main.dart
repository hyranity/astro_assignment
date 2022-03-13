import 'package:astro_assignment/pages/homepage.dart';
import 'package:astro_assignment/pages/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dosisTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}

// Routes go here
var routes = {
  '/': (context) => const MainMenu(),
  '/homepage': (context) => const Homepage(),
};
