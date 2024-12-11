# Core Directory

This directory contains core functionality and utilities used across the application.

## Directory Structure

```
core/
├── constants/     # App Constants
├── theme/        # App Theme
├── network/      # Network Handling
└── widgets/      # Common Widgets
```

## Components

### 📁 constants/
Application-wide constants:
```dart
class ApiConstants {
  static const baseUrl = 'https://api.orange.cm';
  static const timeout = Duration(seconds: 30);
}

class AppConstants {
  static const appName = 'Orange CM';
  static const appVersion = '1.0.0';
}

class StorageKeys {
  static const token = 'auth_token';
  static const user = 'user_data';
}
```

### 📁 theme/
App theming and styling:
```dart
class AppTheme {
  static final light = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      // ... other text styles
    ),
    // ... other theme properties
  );

  static final dark = ThemeData(
    // Dark theme configuration
  );
}

class AppColors {
  static const primary = Color(0xFFFF6B00);
  static const secondary = Color(0xFF333333);
  static const background = Color(0xFFFAFAFA);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
}
```

### 📁 network/
Network handling and interceptors:
```dart
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.timeout,
    ))..interceptors.addAll([
        AuthInterceptor(),
        LoggingInterceptor(),
      ]);
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // ... other HTTP methods
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = Get.find<AuthService>().token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

### 📁 widgets/
Reusable widgets:
```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text(text),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
```

## Testing

### Widget Tests
```dart
void main() {
  group('CustomButton', () {
    testWidgets('should show loading indicator when loading',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CustomButton(
          text: 'Test',
          onPressed: () {},
          isLoading: true,
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });

    testWidgets('should show text when not loading', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CustomButton(
          text: 'Test',
          onPressed: () {},
          isLoading: false,
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
```

## Error Handling

```dart
class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message${code != null ? ' ($code)' : ''}';
}

class NetworkException extends AppException {
  NetworkException(String message, [String? code]) : super(message, code);
}

class ValidationException extends AppException {
  ValidationException(String message, [String? code]) : super(message, code);
}
```

## Utils

```dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
```
