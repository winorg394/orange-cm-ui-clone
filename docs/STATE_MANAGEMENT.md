# State Management with GetX

## Overview

This document outlines the state management patterns used in the Orange CMUI application using the GetX framework.

## Core Concepts

### Controllers

Controllers manage the business logic and state:

```dart
class LoginController extends GetxController {
  // Observable state
  final selectedCountry = Country().obs;
  final phoneNumber = ''.obs;
  
  // Computed state
  RxBool get isValid => phoneNumber.value.length >= 9;
  
  // State updates
  void updatePhone(String value) {
    phoneNumber.value = value;
    validatePhone();
  }
}
```

### Bindings

Bindings handle dependency injection:

```dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
```

## State Management Patterns

### 1. Simple State

For simple values that need reactivity:

```dart
// In controller
final count = 0.obs;

// In view
Obx(() => Text('${controller.count}'))
```

### 2. Complex State

For objects that need reactivity:

```dart
// In controller
final user = User().obs;

// Update specific field
void updateName(String name) {
  user.update((val) {
    val.name = name;
  });
}
```

### 3. Computed State

For values derived from other state:

```dart
// In controller
final firstName = ''.obs;
final lastName = ''.obs;

String get fullName => '${firstName.value} ${lastName.value}';
```

## Best Practices

### 1. Controller Organization

- One controller per feature
- Keep controllers focused
- Use inheritance for shared logic

### 2. State Updates

- Use `.value` for simple types
- Use `.update()` for objects
- Batch updates when possible

### 3. Performance

- Use `.obs` judiciously
- Avoid unnecessary observers
- Clean up resources in `onClose()`

## Error Handling

### 1. Error States

```dart
// In controller
final error = RxnString();

void handleError(String message) {
  error.value = message;
  Future.delayed(Duration(seconds: 3), () {
    error.value = null;
  });
}
```

### 2. Loading States

```dart
// In controller
final isLoading = false.obs;

Future<void> loadData() async {
  isLoading.value = true;
  try {
    // Load data
  } finally {
    isLoading.value = false;
  }
}
```

## Navigation

### 1. Route Management

```dart
// Navigate to named route
Get.toNamed('/login');

// With parameters
Get.toNamed('/profile', arguments: {'id': 123});
```

### 2. Dialog Management

```dart
// Show dialog
Get.dialog(
  MyDialog(),
  barrierDismissible: false,
);

// Show snackbar
Get.snackbar(
  'Success',
  'Operation completed',
  snackPosition: SnackPosition.BOTTOM,
);
```

## Testing

### 1. Controller Tests

```dart
void main() {
  test('LoginController validation', () {
    final controller = LoginController();
    controller.phoneNumber.value = '123';
    expect(controller.isValid, false);
  });
}
```

### 2. Widget Tests with GetX

```dart
testWidgets('Login view', (tester) async {
  await tester.pumpWidget(
    GetMaterialApp(
      home: LoginView(),
      initialBinding: AuthBinding(),
    ),
  );
});
```

## Common Patterns

### 1. Form Management

```dart
class FormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fields = <String, String>{}.obs;
  
  bool validateAndSave() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      return true;
    }
    return false;
  }
}
```

### 2. List Management

```dart
class ListController extends GetxController {
  final items = <Item>[].obs;
  
  void addItem(Item item) {
    items.add(item);
  }
  
  void removeItem(Item item) {
    items.remove(item);
  }
}
```

## Advanced Topics

### 1. Workers

```dart
class AdvancedController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    
    ever(count, (_) {
      print('Count changed');
    });
    
    debounce(
      searchTerm,
      (_) => performSearch(),
      time: Duration(milliseconds: 500),
    );
  }
}
```

### 2. Persistence

```dart
class PersistentController extends GetxController {
  final box = GetStorage();
  
  void saveData(String key, dynamic value) {
    box.write(key, value);
  }
  
  dynamic getData(String key) {
    return box.read(key);
  }
}
```
