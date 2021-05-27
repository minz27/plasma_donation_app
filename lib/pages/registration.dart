import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:plasma_donor_finder/objects/donor.dart';
import 'package:plasma_donor_finder/services/form_controller.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late String _name;
  String _email = "";
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
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isNotEmpty && !EmailValidator.validate(value)) {
          print(EmailValidator.validate(value));
          return "Please enter valid email";
        }
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildContactNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Contact Number"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty || value.length != 10) {
          return "Please enter a valid contact number";
        }
      },
      onSaved: (value) {
        _contactNumber = value!;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Age"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty ||
            (int.parse(value) < 18) ||
            (int.parse(value) > 65)) {
          return "Please confirm that you are between 18 and 65 years of age";
        }
      },
      onSaved: (value) {
        _age = int.parse(value!);
      },
    );
  }

  Widget _buildBloodGroup() {
    var _bloodGroups = ["A+", "O+", "B+", "AB+", "A-", "O-", "B-", "AB-"];
    return DropdownButtonFormField(
        hint: Text("Bloodgroup"),
        items: _bloodGroups.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          setState(() => _bloodGroup = value.toString());
        },
        validator: (value) =>
            value == null ? 'Please select your blood group' : null);
  }

  Widget _buildDistrict() {
    List<String> _districtList = [
      'Baksa',
      'Barpeta',
      'Biswanath',
      'Bongaigaon',
      'Cachar',
      'Charaideo',
      'Chirang',
      'Darrang',
      'Dhemaji',
      'Dhubri',
      'Dibrugarh',
      'Dima Hasao',
      'Goalpara',
      'Golaghat',
      'Hailakandi',
      'Hojai',
      'Jorhat',
      'Kamrup',
      'Kamrup Metropolitan',
      'Karbi Anglong',
      'Karimganj',
      'Kokrajhar',
      'Lakhimpur',
      'Majuli',
      'Morigaon',
      'Nagaon',
      'Nalbari',
      'Sivsagar',
      'Sonitpur',
      'South Salamara Mankachar',
      'Tinsukia',
      'Udalguri',
      'West Karbi Anglong'
    ];
    return DropdownButtonFormField(
      hint: Text("Select your District"),
      items: _districtList.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        setState(() => _district = value.toString());
      },
      validator: (value) =>
          value == null ? 'Please select your district' : null,
    );
  }

  String _formatDate(date) {
    var formatter = new DateFormat('MM/dd/yyyy');
    return formatter.format(date);
  }

  Widget _buildRecoveryDate() {
    DateTime _firstDate = DateTime.now().subtract(Duration(days: 90));
    DateTime _today = DateTime.now();
    return InputDatePickerFormField(
      firstDate: _firstDate,
      lastDate: _today,
      onDateSaved: (value) => _recoveryDate = value,
      fieldLabelText: "Date of recovering from COVID-19",
      errorFormatText: "Please enter date in MM/DD/YYYY format",
      errorInvalidText:
          "Please ensure that your date of recovery is between ${_formatDate(_firstDate)} and ${_formatDate(_today)}",
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
                    _buildContactNumber(),
                    _buildAge(),
                    _buildBloodGroup(),
                    _buildDistrict(),
                    _buildRecoveryDate(),
                    SizedBox(
                      height: 50,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          _formKey.currentState!.save();
                          FormController formController = FormController();
                          print(_name.runtimeType);
                          print(_age.runtimeType);
                          print(_email.runtimeType);
                          print(_bloodGroup.runtimeType);
                          print(_recoveryDate.runtimeType);
                          print(_contactNumber.runtimeType);
                          print(_district.runtimeType);
                          Donor donorDetails = Donor(
                              name: _name,
                              age: _age,
                              bloodGroup: _bloodGroup,
                              recoveryDate: _recoveryDate,
                              contactNumber: _contactNumber.toString(),
                              district: _district,
                              email: _email);
                          formController.submitForm(donorDetails,
                              (String response) {
                            print("Response: $response");
                            if (response == FormController.STATUS_SUCCESS) {
                              // Feedback is saved succesfully in Google Sheets.
                              print("SUCCEES");
                            } else {
                              // Error Occurred while saving data in Google Sheets.
                              print("Error Occurred!");
                            }
                          });
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
