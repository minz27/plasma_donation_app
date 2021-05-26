import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:plasma_donor_finder/objects/donor.dart';

/// FormController is a class which does work of saving Donor in Google Sheets using
/// HTTP POST request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  final url = Uri.parse(
      'https://script.googleusercontent.com/macros/echo?user_content_key=3qU_CvrBwOOgqz-PP5KWDbCdx9RCDbbf4cYOqOWii-Q4rssPckBKRQB_ahU-vYYa_JdRK3dVJ6otBL4MffB8BUc6fL7-v86Pm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnCC_lsBIc2GSl4V0xv7OLWkYbXqZtsy8BCC_J0UCegVlB1VzxCPle6CXT_SFlMUW0zGeASrE4uqNp9nk2bNG35C1TUizkcjB_dz9Jw9Md8uu&lib=MuznE3EfwupQro66XeoWKJ_nMC58ZlW33');

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves donor, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(Donor donor, void Function(String) callback) async {
    try {
      await http.post(url, body: donor.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var locationUrl = response.headers['location'];
          await http.get(Uri.parse(locationUrl.toString())).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
