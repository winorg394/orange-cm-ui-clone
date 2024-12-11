# Coding Standards

## Table of Contents
- [General Guidelines](#general-guidelines)
- [Flutter-Specific Standards](#flutter-specific-standards)
- [Architecture](#architecture)
- [Testing Standards](#testing-standards)
- [Documentation](#documentation)

## General Guidelines

### Code Formatting
- Use the official Dart formatter
```bash
dart format .
```
- Maximum line length: 80 characters
- Use 2 spaces for indentation

### Naming Conventions
- Classes: `UpperCamelCase`
- Variables/functions: `lowerCamelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Private members: `_prefixedWithUnderscore`

### File Organization
```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── themes/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   ├── entities/
│   └── usecases/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── blocs/
└── main.dart
```

## Flutter-Specific Standards

### Widget Structure
```dart
class CustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Widget implementation
    );
  }
}
```

### State Management
- Use BLoC pattern for complex state
- Provider for simple state
- Keep widgets pure and logic-free
- Separate business logic from UI

### Performance Guidelines
- Use const constructors when possible
- Minimize widget rebuilds
- Use lazy loading for lists
- Optimize image assets

## Architecture

### Clean Architecture Principles
1. **Presentation Layer**
   - Widgets
   - Pages
   - BLoCs

2. **Domain Layer**
   - Use Cases
   - Entities
   - Repository Interfaces

3. **Data Layer**
   - Repositories
   - Data Sources
   - Models

### Dependency Injection
- Use GetIt for dependency injection
- Register dependencies at app startup
- Use factories for runtime dependencies

## Testing Standards

### Unit Tests
```dart
void main() {
  group('Authentication Tests', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: mockAuthRepository);
    });

    test('initial state is correct', () {
      expect(authBloc.state, AuthInitial());
    });
  });
}
```

### Widget Tests
```dart
void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyWidget(title: 'Test'),
      ),
    );

    final titleFinder = find.text('Test');
    expect(titleFinder, findsOneWidget);
  });
}
```

## Documentation

### Code Documentation
```dart
/// A service that handles user authentication.
///
/// This service manages user login, registration, and session management.
/// It interfaces with the backend API and local storage to maintain
/// user authentication state.
class AuthenticationService {
  /// Attempts to log in a user with the provided credentials.
  ///
  /// Returns a [User] object if successful, throws [AuthException] otherwise.
  /// 
  /// Parameters:
  /// - [email] The user's email address
  /// - [password] The user's password
  Future<User> login({
    required String email,
    required String password,
  }) async {
    // Implementation
  }
}
```

### API Documentation
- Use OpenAPI/Swagger for API documentation
- Document all endpoints
- Include request/response examples
- Document error cases

### Commit Messages
Follow Conventional Commits:
```
feat: add user authentication
fix: resolve login screen crash
docs: update API documentation
style: format code according to guidelines
refactor: restructure authentication flow
test: add unit tests for auth service
chore: update dependencies
```

## Error Handling

### Exception Hierarchy
```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);
}

class NetworkException extends AppException {
  NetworkException(String message, [String? code]) 
    : super(message, code);
}
```

### Error Reporting
- Use proper error boundaries
- Log errors appropriately
- Provide user-friendly error messages

## Security Standards

1. **Data Storage**
   - Use secure storage for sensitive data
   - Encrypt stored credentials
   - Clear sensitive data on logout

2. **Network Security**
   - Use HTTPS for all network calls
   - Implement certificate pinning
   - Validate all server responses

3. **Input Validation**
   - Sanitize all user inputs
   - Validate data formats
   - Prevent injection attacks

## Accessibility

1. **Semantic Widgets**
   - Use proper semantic labels
   - Implement proper navigation
   - Support screen readers

2. **Color Contrast**
   - Maintain WCAG 2.1 standards
   - Support dark mode
   - Test with color blindness simulators

## Performance Standards

1. **Load Time**
   - App launch < 2 seconds
   - Screen transition < 300ms
   - API response < 1 second

2. **Memory Usage**
   - Monitor memory leaks
   - Implement proper disposal
   - Cache appropriately

## Version Control

1. **Branch Protection**
   - Require code reviews
   - Enforce status checks
   - Protect main branch

2. **CI/CD Integration**
   - Automated testing
   - Code quality checks
   - Automated deployment
