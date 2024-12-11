# Data Layer

This directory implements the data layer of the application, following Clean Architecture principles.

## Directory Structure

```
data/
├── models/          # Data Transfer Objects
├── providers/       # Data Sources
└── repositories/    # Repository Implementations
```

## Components

### 📁 models/
Data Transfer Objects (DTOs) that map to/from JSON:
```dart
class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };

  // Map to domain entity
  User toDomain() => User(
    id: id,
    name: name,
    email: email,
  );
}
```

### 📁 providers/
Data sources (API clients, local storage):
```dart
class ApiProvider {
  final Dio _dio;

  ApiProvider(): _dio = Dio(BaseOptions(
    baseUrl: 'https://api.orange.cm',
    connectTimeout: Duration(seconds: 5),
  ));

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
```

### 📁 repositories/
Implementation of domain repository interfaces:
```dart
class UserRepositoryImpl implements UserRepository {
  final ApiProvider _apiProvider;
  final LocalStorage _localStorage;

  UserRepositoryImpl(this._apiProvider, this._localStorage);

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final response = await _apiProvider.get('/users/$id');
      final user = UserModel.fromJson(response.data).toDomain();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

## Testing

Each component should have corresponding tests:

### Model Tests
```dart
void main() {
  group('UserModel', () {
    test('should create UserModel from JSON', () {
      // Arrange
      final json = {
        'id': '1',
        'name': 'John Doe',
        'email': 'john@example.com',
      };

      // Act
      final result = UserModel.fromJson(json);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'John Doe');
      expect(result.email, 'john@example.com');
    });
  });
}
```

### Repository Tests
```dart
void main() {
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl repository;
    late MockApiProvider mockApiProvider;
    late MockLocalStorage mockLocalStorage;

    setUp(() {
      mockApiProvider = MockApiProvider();
      mockLocalStorage = MockLocalStorage();
      repository = UserRepositoryImpl(
        mockApiProvider,
        mockLocalStorage,
      );
    });

    test('should return User when API call is successful', () async {
      // Arrange
      when(mockApiProvider.get(any))
          .thenAnswer((_) async => Response(
                data: userJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // Act
      final result = await repository.getUser('1');

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (user) {
          expect(user.id, '1');
          expect(user.name, 'John Doe');
        },
      );
    });
  });
}
```

## Error Handling

Use Either type for error handling:
```dart
Either<Failure, Success> handleError<Success>(
  Future<Success> Function() call
) async {
  try {
    final result = await call();
    return Right(result);
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  } on CacheException catch (e) {
    return Left(CacheFailure(message: e.message));
  }
}
```
