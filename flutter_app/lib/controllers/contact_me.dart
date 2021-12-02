import 'package:flutter/material.dart';
import 'package:flutter_app/services/cloud_functions.dart';
import 'package:get/get.dart';


class ContactMeController extends GetxController {
  final _name = 'Name (required)'.obs;
  final _company = 'Company (optional)'.obs;
  final _email = 'Email (required)'.obs;
  final _question = 'Questions? Ask away! (optional) '.obs;
  final _showForm = true.obs;
  final _focusNode = FocusNode().obs;
  final _functionsService = CloudFunctionsService();

  String get name => _name.value;
  String get company => _company.value;
  String get email => _email.value;
  String get question => _question.value;
  bool get showForm => _showForm.value;
  FocusNode get focusNode => _focusNode.value;

  set name(String val) => this._name.value = val;
  set company(String val) => this._company.value = val;
  set email(String val) => this._email.value = val;
  set question(String val) => this._question.value = val;
  set showForm(bool val) => this._showForm.value = val;
  set focusNode(FocusNode node) => this._focusNode.value = node;

  void requestFocus() => _focusNode.value.requestFocus();

  void sendEmail([Map<String, String> ?params]) async {
    // var client = http.Client();
    // try {
    //   var baseUrl = 'secretmanager.googleapis.com';
    //   var secretKeyUrl = Uri(
    //       scheme: 'https',
    //       host: baseUrl,
    //       path: '/v1/projects/123181321826/secrets/SECRET_KEY/versions/latest');
    //   var sendgridKeyUrl = Uri(
    //       scheme: 'https',
    //       host: baseUrl,
    //       path: '/v1/projects/123181321826/secrets/SENDGRID_API_KEY/versions/latest');
    //
    //   var secretKeyResponse = await http.get(secretKeyUrl);
    //   var secretKey = json.decode(utf8.decode(secretKeyResponse.bodyBytes));
    //   print(secretKey);
    //
    //   var sendgridKeyResponse = await http.get(sendgridKeyUrl);
    //   var sendgridKey = json.decode(utf8.decode(secretKeyResponse.bodyBytes));
    // } finally {
    //   client.close();
    // }

    var _data = params ?? <String, String>{
      "name": _name.value,
      "email": _email.value,
      "company": _company.value,
      "question": _question.value
    };
    var sent = await _functionsService.callFunction('contactMeEmailEndpoint', _data);
    if (sent) {
      Get.snackbar('Message sent', 'Your contact request was sent.', snackPosition: SnackPosition.BOTTOM);
      _updateShowForm(false);
    }
  }

  void _updateShowForm(bool val) {
    _showForm.value = val;
    update();
  }
}