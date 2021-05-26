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

  Future<void> _sendingEmail(url) async {
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
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '${donorsList[index].name}',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Blood Group: ${donorsList[index].bloodGroup}',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Age: ${donorsList[index].age}',
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.call),
                                    color: Colors.green[400],
                                    onPressed: () {
                                      String formattedNumber = "tel:" +
                                          donorsList[index].contactNumber;
                                      _makingPhoneCall(formattedNumber);
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      String formattedMail =
                                          "mailto:" + donorsList[index].email;
                                      _sendingEmail(formattedMail);
                                    },
                                    icon: Icon(Icons.email),
                                    color: Colors.pink[500],
                                  )
                                ],
                              )
                            ],
                          ),
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
