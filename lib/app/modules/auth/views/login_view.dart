import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Back button
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Get.back(),
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              // Welcome text
              Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Entrez votre numéro de téléphone pour continuer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // Phone input container
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Country selector
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.7,
                                  minChildSize: 0.5,
                                  maxChildSize: 0.9,
                                  expand: false,
                                  builder: (context, scrollController) => Column(
                                    children: [
                                      // Handle
                                      Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        height: 4,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Title
                                      const Text(
                                        'Sélectionnez votre pays',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Search
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Rechercher un pays',
                                            prefixIcon: const Icon(Icons.search_rounded),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                          ),
                                          onChanged: controller.updateSearchQuery,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Countries list
                                      Expanded(
                                        child: Obx(() {
                                          final filteredCountries = controller.filteredCountries;
                                          return ListView.builder(
                                            controller: scrollController,
                                            itemCount: filteredCountries.length,
                                            itemBuilder: (context, index) {
                                              final country = filteredCountries[index];
                                              return InkWell(
                                                onTap: () {
                                                  controller.selectedCountry.value = country;
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        country.flag,
                                                        style: const TextStyle(fontSize: 32),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Text(
                                                          country.name,
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        country.dialCode,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey[600],
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey[200]!),
                              ),
                            ),
                            child: Obx(() {
                              final selectedCountry = controller.selectedCountry.value;
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selectedCountry.flag,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedCountry.dialCode,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        // Phone input
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            focusNode: controller.focusNode,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                            decoration: InputDecoration(
                              hintText: '6 XX XX XX XX',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            onChanged: controller.updatePhoneNumber,
                          ),
                        ),
                      ],
                    ),
                    // Error message
                    Obx(() {
                      final error = controller.errorMessage.value;
                      if (error == null) return const SizedBox.shrink();
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          top: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 16,
                              color: Colors.red[700],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const Spacer(),
              // Continue button
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Obx(() {
                  final isValid = controller.isValidPhone.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isValid ? controller.onContinuePressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isValid
                            ? const Color(0xFFFF6B00)
                            : const Color(0xFFF5F5F5),
                        foregroundColor: isValid
                            ? Colors.white
                            : const Color(0xFF9E9E9E),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continuer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: isValid
                                  ? Colors.white
                                  : const Color(0xFF9E9E9E),
                            ),
                          ),
                          if (isValid) ...[
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: isValid ? Colors.white : const Color(0xFF9E9E9E),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
