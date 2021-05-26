import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/pages/districts.dart';
import 'package:plasma_donor_finder/pages/donors.dart';
import 'package:plasma_donor_finder/pages/home.dart';
import 'package:plasma_donor_finder/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/district': (context) => DistrictsPage(),
      '/donors': (context) => DonorsPage(),
      '/loading': (context) => LoadingScreen(),
    },
    theme: ThemeData.light(),
  ));
}
