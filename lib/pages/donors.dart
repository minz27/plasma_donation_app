import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/objects/donor.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorsPage extends StatefulWidget {
  @override
  _DonorsPageState createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {
  late List<Donor> donorsList;
  late bool isDonorAvailable;

  void initialiseDonorsList() {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    donorsList = data["donorsList"];
    isDonorAvailable = donorsList.isNotEmpty;
  }

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
    initialiseDonorsList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text(
            'Available Donors',
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: isDonorAvailable
                ? ListView.builder(
                    itemCount: donorsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${donorsList[index].name}'),
                          subtitle: Text(
                              'Blood Group: ${donorsList[index].bloodGroup}'),
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
                  )
                : Text(
                    "We're sorry but no donors are registered in your district right now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )));
  }
}
