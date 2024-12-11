# Modules Directory

This directory contains feature modules of the application, each following GetX patterns and Clean Architecture principles.

## Directory Structure

```
modules/
├── auth/           # Authentication Module
├── home/           # Home Module
└── profile/        # Profile Module
```

Each module follows this structure:
```
module_name/
├── bindings/      # GetX Dependency Injection
├── controllers/   # GetX Controllers
├── views/         # UI Components
└── widgets/       # Module-specific Widgets
```

## Module Implementation

### 📁 bindings/
Module dependency injection:
```dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<AuthController>(() => AuthController(
      loginUseCase: Get.find(),
      registerUseCase: Get.find(),
    ));

    // Use Cases
    Get.lazyPut(() => Login(Get.find()));
    Get.lazyPut(() => Register(Get.find()));

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find()),
    );
  }
}
```

### 📁 controllers/
GetX controllers with reactive state:
```dart
class AuthController extends GetxController {
  final Login _loginUseCase;
  final Register _registerUseCase;

  final RxBool isLoading = false.obs;
  final Rx<User?> user = Rx<User?>(null);

  AuthController({
    required Login loginUseCase,
    required Register registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final params = LoginParams(email: email, password: password);
    
    final result = await _loginUseCase(params);
    
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (user) => this.user.value = user,
    );
    
    isLoading.value = false;
  }
}
```

### 📁 views/
UI implementation using GetX:
```dart
class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
        ? LoadingIndicator()
        : LoginForm(
            onSubmit: (email, password) => 
              controller.login(email, password),
          ),
      ),
    );
  }
}
```

### 📁 widgets/
Reusable module-specific widgets:
```dart
class LoginForm extends StatelessWidget {
  final Function(String email, String password) onSubmit;

  const LoginForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            isPassword: true,
          ),
          ElevatedButton(
            onPressed: () => onSubmit(
              emailController.text,
              passwordController.text,
            ),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

## Testing

### Controller Tests
```dart
void main() {
  group('AuthController Tests', () {
    late AuthController controller;
    late MockLogin mockLogin;
    late MockRegister mockRegister;

    setUp(() {
      mockLogin = MockLogin();
      mockRegister = MockRegister();
      controller = AuthController(
        loginUseCase: mockLogin,
        registerUseCase: mockRegister,
      );
    });

    test('login success should update user', () async {
      // Arrange
      final user = User(id: '1', name: 'Test');
      when(mockLogin(any))
          .thenAnswer((_) async => Right(user));

      // Act
      await controller.login('test@example.com', 'password');

      // Assert
      expect(controller.user.value, user);
      expect(controller.isLoading.value, false);
    });
  });
}
```

### Widget Tests
```dart
void main() {
  testWidgets('LoginForm should call onSubmit', (tester) async {
    // Arrange
    String? submittedEmail;
    String? submittedPassword;

    await tester.pumpWidget(MaterialApp(
      home: LoginForm(
        onSubmit: (email, password) {
          submittedEmail = email;
          submittedPassword = password;
        },
      ),
    ));

    // Act
    await tester.enterText(
      find.byType(TextField).first,
      'test@example.com',
    );
    await tester.enterText(
      find.byType(TextField).last,
      'password',
    );
    await tester.tap(find.byType(ElevatedButton));

    // Assert
    expect(submittedEmail, 'test@example.com');
    expect(submittedPassword, 'password');
  });
}
```

## Navigation

Use GetX navigation:
```dart
class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const profile = '/profile';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
```
