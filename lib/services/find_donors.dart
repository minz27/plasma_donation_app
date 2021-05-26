import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:plasma_donor_finder/objects/donor.dart';

class DonorsList {
  late List<Donor> donorsList;
  String district;

  DonorsList({required this.district});

  Future<void> findDonors() async {
    final client = RetryClient(Client());
    final url = Uri.parse(
        'https://script.googleusercontent.com/macros/echo?user_content_key=3qU_CvrBwOOgqz-PP5KWDbCdx9RCDbbf4cYOqOWii-Q4rssPckBKRQB_ahU-vYYa_JdRK3dVJ6otBL4MffB8BUc6fL7-v86Pm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnCC_lsBIc2GSl4V0xv7OLWkYbXqZtsy8BCC_J0UCegVlB1VzxCPle6CXT_SFlMUW0zGeASrE4uqNp9nk2bNG35C1TUizkcjB_dz9Jw9Md8uu&lib=MuznE3EfwupQro66XeoWKJ_nMC58ZlW33');
    try {
      Response response = await get(url);
      Iterable data = jsonDecode(response.body);
      donorsList = List<Donor>.from(data.map((model) => Donor.fromJson(model)));
      //filter donor by district
      donorsList =
          donorsList.where((i) => i.district == this.district).toList();
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }
}
