import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late String _name;
  late String _email;
  late String _contactNumber;
  late int _age;
  late String _bloodGroup;
  late DateTime _recoveryDate;
  late String _district;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Name is required";
        }
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text("Register as Donor"),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildName(),
                    _buildEmail(),
                    _buildName(),
                    _buildName(),
                    _buildName(),
                    // _buildEmail(),
                    SizedBox(
                      height: 50,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        print("Beepboop");
                        if (_formKey.currentState!.validate()) {
                          return;
                        }
                      },
                      icon: Icon(
                        Icons.app_registration_outlined,
                      ),
                      label: Text("Register"),
                      backgroundColor: Colors.pink[500],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            )));
  }
}
