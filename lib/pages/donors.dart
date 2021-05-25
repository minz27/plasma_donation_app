import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/objects/donor.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorsPage extends StatefulWidget {
  @override
  _DonorsPageState createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {
  final url =
      'https://script.googleusercontent.com/macros/echo?user_content_key=ytpD13b2rcnMRr0JS431IJepSNkguvJnzXdJM5FlmYrMZtayfq3VpK4GMSLp93mahk3QXupQ9mR6ooFdZtALLOlYlzoplMuLm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnEtww7LIpXsBWeI5_eJd6lCqNqRt4G4RPrsdXyalMPBcOLzEduAJYrTIqu8le1J9hf4hYZEVdkVwWx0nxXID6gGxgrGJS70509z9Jw9Md8uu&lib=MuznE3EfwupQro66XeoWKJ_nMC58ZlW33';
  List<Donor> donorsList = [
    Donor(
        id: 1,
        name: 'Mreenav',
        age: 25,
        bloodGroup: 'O+',
        recoveryDate: DateTime.parse('2021-11-11'),
        contactNumber: 'tel:9706749444',
        district: 'Kamrup Metro',
        email: 'mreenav@gmail.com')
  ];

  DateTime formatDate(String date) {
    String formattedString = date.substring(
          6,
        ) +
        "-" +
        date.substring(0, 2) +
        "-" +
        date.substring(3, 5);
    return DateTime.parse(formattedString);
  }

  Future<void> _makingPhoneCall(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text(
            'Available Donors',
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: ListView.builder(
              itemCount: donorsList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${donorsList[index].name}'),
                    subtitle:
                        Text('Blood Group: ${donorsList[index].bloodGroup}'),
                    trailing: IconButton(
                      icon: Icon(Icons.call),
                      color: Colors.green[400],
                      onPressed: () {
                        _makingPhoneCall(donorsList[index].contactNumber);
                      },
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            )));
  }
}
