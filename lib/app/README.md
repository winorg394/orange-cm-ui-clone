# App Directory

This directory contains the main application code organized following Clean Architecture principles and GetX patterns.

## Structure

### 📁 bindings/
Contains GetX dependency injection configurations:
```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
  }
}
```

### 📁 data/
Data layer implementation:
- **models/**: Data transfer objects
- **providers/**: API clients and local storage
- **repositories/**: Repository implementations

### 📁 domain/
Business logic and rules:
- **entities/**: Business objects
- **repositories/**: Repository interfaces
- **usecases/**: Business use cases

### 📁 modules/
Feature modules, each containing:
- **views/**: UI components
- **controllers/**: GetX controllers
- **bindings/**: Module bindings
- **repositories/**: Module-specific repositories

## Testing

Each component follows TDD principles:

1. **Unit Tests**
```dart
void main() {
  group('HomeController Tests', () {
    late HomeController controller;
    late MockHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockHomeRepository();
      controller = HomeController(repository: mockRepository);
    });

    test('should get initial data', () async {
      // Arrange
      when(mockRepository.getData())
          .thenAnswer((_) async => Right(TestData.mockData));

      // Act
      await controller.getData();

      // Assert
      expect(controller.data.value, TestData.mockData);
    });
  });
}
```

2. **Integration Tests**
```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('complete flow test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Test steps...
  });
}
```

## GetX State Management

Controllers use reactive programming:
```dart
class HomeController extends GetxController {
  final Rx<User> user = User().obs;
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final result = await repository.getData();
      products.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}
```
