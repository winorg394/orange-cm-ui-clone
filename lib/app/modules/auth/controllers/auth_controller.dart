import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final isValidPhone = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = phoneController.text;
    // Validate Cameroon phone number format
    isValidPhone.value = phone.length == 9 && 
                        (phone.startsWith('6') || phone.startsWith('2'));
  }

  void verifyPhone() {
    if (isValidPhone.value) {
      // Here you would typically make an API call to verify the phone number
      // For now, we'll just navigate to the next screen
      Get.toNamed('/verify', arguments: phoneController.text);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
