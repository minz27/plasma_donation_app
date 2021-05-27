class Donor {
  String name;
  int age;
  String bloodGroup;
  DateTime recoveryDate;
  String contactNumber;
  String district;
  String email;

  Donor(
      {required this.name,
      required this.age,
      required this.bloodGroup,
      required this.recoveryDate,
      required this.contactNumber,
      required this.district,
      required this.email});

  Donor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        age = json['age'],
        bloodGroup = json['bloodGroup'],
        recoveryDate = DateTime.parse(json['recoveryDate']),
        contactNumber = json['contactNumber'].toString(),
        district = json['district'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'age': age.toString(),
        'bloodGroup': bloodGroup,
        'recoveryDate': recoveryDate.toString(),
        'contactNumber': contactNumber.toString(),
        'district': district
      };
}
