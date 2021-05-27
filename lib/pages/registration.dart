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
  DateTime _recoveryDate = DateTime.now();
  late String _district;

  Widget _buildName() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Name *", icon: Icon(Icons.text_fields)),
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
      decoration: InputDecoration(labelText: "Email", icon: Icon(Icons.email)),
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
      decoration: InputDecoration(
          labelText: "Contact Number *", icon: Icon(Icons.phone)),
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
      decoration:
          InputDecoration(labelText: "Age *", icon: Icon(Icons.text_fields)),
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
        hint: Text("Blood Group *"),
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
      hint: Text("Select your District *"),
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

  TextEditingController _textEditingController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime _firstDate = DateTime.now().subtract(Duration(days: 90));
    DateTime _today = DateTime.now();
    DateTime? picked = await showDatePicker(
        helpText: "Date of recovery from COVID-19",
        context: context,
        initialDate: _today,
        firstDate: _firstDate,
        lastDate: _today);
    setState(() {
      if (null != picked) {
        _recoveryDate = picked;
      } else {
        _recoveryDate = _today;
      }
    });
  }

  Widget _buildRecoveryDate() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Date of Recovery from COVID-19",
          icon: Icon(Icons.calendar_today)),
      controller: _textEditingController,
      onTap: () async {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        // Show Date Picker Here
        await _selectDate(context);
        _textEditingController.text =
            DateFormat('yyyy/MM/dd').format(_recoveryDate);
        //setState(() {});
      },
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final snackBarSuccess = SnackBar(
    content: Text('You are successfully registered!'),
    backgroundColor: Colors.green,
  );
  final snackBarFailure = SnackBar(
    content: Text('An error occured. Please try again later'),
    backgroundColor: Colors.red,
  );
  final snackBarCurrent = SnackBar(content: Text("Getting you registered.."));

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
                    _buildRecoveryDate(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildBloodGroup(),
                    _buildDistrict(),
                    SizedBox(
                      height: 50,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarCurrent);
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
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarSuccess);
                              // Data is saved succesfully in Google Sheets.
                              print("SUCCEES");
                              Navigator.pop(context);
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
