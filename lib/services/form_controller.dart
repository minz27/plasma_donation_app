import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:plasma_donor_finder/objects/donor.dart';

/// FormController is a class which does work of saving Donor in Google Sheets using
/// HTTP POST request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  final url = Uri.parse(
      'https://script.google.com/macros/s/AKfycbyj2jpcOuQAKsSgaPWo-nEchc5MKlp7yxKSYCqCiimkPcDNKlQKJeEm1kx_G-_R7pPM/exec');

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
