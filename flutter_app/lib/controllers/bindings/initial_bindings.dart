import 'package:flutter_app/controllers/contact_me.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactMeController>(ContactMeController());
  }
}