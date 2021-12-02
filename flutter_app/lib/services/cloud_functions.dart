import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class CloudFunctionsService {
  final FirebaseFunctions _cloudFunctions = FirebaseFunctions.instance;

  CloudFunctionsService() {
    if (kDebugMode) _cloudFunctions.useFunctionsEmulator('localhost', 5001);
  }

  Future<bool> callFunction(String function, Map<String, String> data) async {
    try {
      HttpsCallable callable = _cloudFunctions.httpsCallable(function);

      final res = await callable(data);
      return res.data ?? false;
    } catch (e) {
      Get.snackbar('Email not sent', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}