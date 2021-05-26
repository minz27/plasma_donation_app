import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plasma_donor_finder/services/find_donors.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late DonorsList donorsList;

  void _getDonors() async {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    DonorsList donorsList = DonorsList(district: data["districtName"]);
    print(data["districtName"]);
    await donorsList.findDonors();

    Navigator.pushReplacementNamed(context, '/donors',
        arguments: {'donorsList': donorsList.donorsList});
  }

  @override
  void initState() {
    super.initState();
    // _getDonors();
  }

  @override
  Widget build(BuildContext context) {
    _getDonors();
    return Scaffold(
        backgroundColor: Colors.purple[900],
        body: Center(
            child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
