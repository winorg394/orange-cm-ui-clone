import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 0.6, 1.0],
            colors: [
              Colors.white,
              Color(0xFFFFF5EC),
              Color(0xFFFFE8D6),
              Color(0xFFFFD6B8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Hero image with shadow
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/onboarding.png',
                      height: 240,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 240,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Image non disponible',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                // Welcome text with subtle animation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Text(
                        'Bienvenue sur Max it',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Votre nouvelle Application Orange qui facilite et sécurise vos transactions.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4F5565),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Buttons with elevation and hover effect
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B00).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.LOGIN),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Se connecter au numéro mobile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    // Guest access button with glass effect
                    Container(
                      width: double.infinity,
                      height: 52,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Get.toNamed(Routes.GUEST),
                                splashColor: const Color(0xFFFF6B00).withOpacity(0.1),
                                highlightColor: Colors.white.withOpacity(0.2),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: const Duration(milliseconds: 600),
                                        builder: (context, value, child) {
                                          return Transform.scale(
                                            scale: 0.8 + (0.2 * value),
                                            child: Opacity(
                                              opacity: value,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          size: 20,
                                          color: const Color(0xFF4F5565).withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: const Duration(milliseconds: 600),
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset: Offset(10 * (1 - value), 0),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Accéder en tant que visiteur',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.3,
                                            color: Color(0xFF4F5565),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
