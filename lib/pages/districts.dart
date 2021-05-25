import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/objects/district.dart';

class DistrictsPage extends StatefulWidget {
  @override
  _DistrictsPageState createState() => _DistrictsPageState();
}

class _DistrictsPageState extends State<DistrictsPage> {
  List<District> districtList = [
    District(districtName: 'Baksa'),
    District(districtName: 'Barpeta'),
    District(districtName: 'Biswanath'),
    District(districtName: 'Bongaigaon'),
    District(districtName: 'Cachar'),
    District(districtName: 'Charaideo'),
    District(districtName: 'Chirang'),
    District(districtName: 'Darrang'),
    District(districtName: 'Dhemaji'),
    District(districtName: 'Dhubri'),
    District(districtName: 'Dibrugarh'),
    District(districtName: 'Dima Hasao'),
    District(districtName: 'Goalpara'),
    District(districtName: 'Golaghat'),
    District(districtName: 'Hailakandi'),
    District(districtName: 'Hojai'),
    District(districtName: 'Jorhat'),
    District(districtName: 'Kamrup'),
    District(districtName: 'Kamrup Metropolitan'),
    District(districtName: 'Karbi Anglong'),
    District(districtName: 'Karimganj'),
    District(districtName: 'Kokrajhar'),
    District(districtName: 'Lakhimpur'),
    District(districtName: 'Majuli'),
    District(districtName: 'Morigaon'),
    District(districtName: 'Nagaon'),
    District(districtName: 'Nalbari'),
    District(districtName: 'Sivsagar'),
    District(districtName: 'Sonitpur'),
    District(districtName: 'South Salamara Mankachar'),
    District(districtName: 'Tinsukia'),
    District(districtName: 'Udalguri'),
    District(districtName: 'West Karbi Anglong'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text(
            'Select District',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: districtList.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        districtList[index].districtName,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
