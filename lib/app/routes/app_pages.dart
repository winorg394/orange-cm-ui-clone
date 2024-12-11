import 'package:get/get.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/controllers/splash_controller.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding/controllers/onboarding_controller.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/auth/controllers/login_controller.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
  ];
}
