import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> nameController =
      TextEditingController(text: "Fatima Jannat").obs;
  Rx<TextEditingController> emailController =
      TextEditingController(text: "fatima@gmail.com").obs;
  Rx<TextEditingController> phoneController =
      TextEditingController(text: "+880232480457").obs;
  Rx<TextEditingController> locationController =
      TextEditingController(text: "Saudi Arab").obs;
}
