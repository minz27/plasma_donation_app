import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text(
            'Home',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Image(
                    image: AssetImage('assets/assam_icon.png'),
                  ),
                  title: Text('Search for Plasma Donors'),
                  subtitle: Text(
                      'Find and contact registered Plasma Donors in your district'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.pushNamed(context, '/district');
                    print('Tapped');
                  },
                ),
                elevation: 2,
              ),
              SizedBox(
                height: 200.0,
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                ),
                label: Text("Register as Donor"),
                backgroundColor: Colors.pink[500],
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "Disclaimer: All data has been provided by users on a voluntary basis. Users are advised to exercise caution while contacting donors.",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
