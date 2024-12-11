import 'package:get/get.dart';
import '../../../data/models/country.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  // Selected country
  final selectedCountry = countries.firstWhere((c) => c.code == 'CM').obs;

  // Phone number
  final phoneNumber = ''.obs;
  final isValidPhone = false.obs;
  final phoneController = TextEditingController();
  final focusNode = FocusNode();

  // Search query for country search
  final searchQuery = ''.obs;

  // Error message
  final errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    // Listen to phone number changes
    ever(phoneNumber, validatePhone);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        errorMessage.value = null;
      }
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // Filtered countries based on search
  List<Country> get filteredCountries {
    if (searchQuery.value.isEmpty) {
      return countries;
    }
    return countries.where((country) {
      return country.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          country.dialCode.contains(searchQuery.value);
    }).toList();
  }

  // Update phone number
  void updatePhoneNumber(String value) {
    // Remove any non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Format the phone number as user types
    if (digitsOnly.isNotEmpty) {
      String formatted = '';
      for (var i = 0; i < digitsOnly.length; i++) {
        if (i == 0) formatted += digitsOnly[i];
        else if (i % 2 == 0) formatted += ' ${digitsOnly[i]}';
        else formatted += digitsOnly[i];
      }
      phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      phoneController.clear();
    }
    
    phoneNumber.value = digitsOnly;
  }

  // Validate phone number
  void validatePhone(String phone) {
    if (phone.isEmpty) {
      errorMessage.value = 'Veuillez entrer un numéro de téléphone';
      isValidPhone.value = false;
      return;
    }

    // Cameroon phone number validation (example: should start with 6 and be 9 digits)
    if (selectedCountry.value.code == 'CM') {
      if (!phone.startsWith('6')) {
        errorMessage.value = 'Le numéro doit commencer par 6';
        isValidPhone.value = false;
        return;
      }
      if (phone.length != 9) {
        errorMessage.value = 'Le numéro doit contenir 9 chiffres';
        isValidPhone.value = false;
        return;
      }
    } else {
      // Generic validation for other countries
      if (phone.length < 8 || phone.length > 12) {
        errorMessage.value = 'Le numéro doit contenir entre 8 et 12 chiffres';
        isValidPhone.value = false;
        return;
      }
    }

    errorMessage.value = null;
    isValidPhone.value = true;
  }

  // Update search query
  void updateSearchQuery(String value) {
    searchQuery.value = value;
  }

  // Handle continue button press
  void onContinuePressed() {
    if (!isValidPhone.value) {
      focusNode.requestFocus();
      return;
    }
    
    // Proceed with phone verification
    final fullNumber = '${selectedCountry.value.dialCode}${phoneNumber.value}';
    // Add your phone verification logic here
    print('Verifying phone number: $fullNumber');
  }
}
