import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/pages/districts.dart';
import 'package:plasma_donor_finder/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/district': (context) => DistrictsPage(),
    },
    theme: new ThemeData(scaffoldBackgroundColor: const Color(0xE0E0E0)),
  ));
}
