# Domain Layer

This directory contains the business logic of the application, following Clean Architecture principles.

## Directory Structure

```
domain/
├── entities/       # Business Objects
├── repositories/   # Repository Interfaces
└── usecases/      # Business Use Cases
```

## Components

### 📁 entities/
Pure business objects:
```dart
class User {
  final String id;
  final String name;
  final String email;
  final UserType type;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  bool get isAdmin => type == UserType.admin;
}
```

### 📁 repositories/
Repository interfaces:
```dart
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, void>> updateUser(User user);
}
```

### 📁 usecases/
Business use cases following Clean Architecture:
```dart
class GetUser implements UseCase<User, String> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String params) async {
    return await repository.getUser(params);
  }
}
```

## Testing

Each component should be thoroughly tested:

### Entity Tests
```dart
void main() {
  group('User Entity', () {
    test('should return true for admin user', () {
      // Arrange
      final user = User(
        id: '1',
        name: 'Admin',
        email: 'admin@example.com',
        type: UserType.admin,
      );

      // Act & Assert
      expect(user.isAdmin, true);
    });
  });
}
```

### Use Case Tests
```dart
void main() {
  group('GetUser Use Case', () {
    late GetUser useCase;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      useCase = GetUser(mockRepository);
    });

    test('should get user from repository', () async {
      // Arrange
      final user = User(id: '1', name: 'Test', email: 'test@example.com');
      when(mockRepository.getUser(any))
          .thenAnswer((_) async => Right(user));

      // Act
      final result = await useCase('1');

      // Assert
      expect(result, Right(user));
      verify(mockRepository.getUser('1'));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
```

## Failure Handling

Define domain-specific failures:
```dart
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Error'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache Error'}) : super(message);
}
```

## Use Case Template

Base use case class:
```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
```

## Value Objects

Implement value objects for complex business rules:
```dart
class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}
```
