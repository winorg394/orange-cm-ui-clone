# Orange CMUI Mobile App

A modern and user-friendly mobile application built with Flutter and GetX, featuring a beautiful authentication flow and country selection functionality.

## Features

### Authentication Flow
- **Modern Login UI**
  - Clean and minimalist design
  - Smooth animations and transitions
  - Intuitive user feedback
  - Responsive layout adapting to different screen sizes

- **Phone Number Authentication**
  - Country selection with flag and dial code
  - Real-time phone number validation
  - Smart formatting as users type
  - Clear error messages with visual feedback

- **Country Selector**
  - Beautiful bottom sheet design
  - Search functionality for countries
  - Organized list with flags and dial codes
  - Smooth scrolling and selection experience

### UI/UX Features
- **Modern Design Elements**
  - Consistent typography and spacing
  - Thoughtful color scheme
  - Interactive animations
  - Clear visual hierarchy

- **User Feedback**
  - Real-time validation
  - Contextual error messages
  - Loading states
  - Success animations

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/orangecmui.git
```

2. Navigate to the project directory:
```bash
cd orangecmui
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── app/
│   ├── data/
│   │   └── models/
│   │       └── country.dart      # Country model definition
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── bindings/        # Dependencies injection
│   │   │   ├── controllers/     # Business logic
│   │   │   └── views/          # UI components
│   │   ├── splash/             # Splash screen module
│   │   └── onboarding/         # Onboarding module
│   └── routes/
│       └── app_pages.dart      # Route definitions
```

## Architecture

The app follows the GetX pattern with a clean architecture approach:

- **Models**: Data classes that define the structure of our objects
- **Controllers**: Business logic and state management
- **Bindings**: Dependency injection and initialization
- **Views**: UI components and screens
- **Routes**: Navigation and routing definitions

## UI Components

### LoginView
The login screen features:
- Custom back button
- Welcome message section
- Phone input field with country selector
- Validation feedback
- Continue button with state management

### Country Selector
A bottom sheet component with:
- Search functionality
- Scrollable country list
- Flag and dial code display
- Selection feedback

## State Management

The app uses GetX for state management:
- Reactive state variables with `.obs`
- Dependency injection with bindings
- Route management with Get.toNamed()
- Simple and powerful reactive programming

## Validation Rules

Phone number validation includes:
- Country-specific formatting
- Length validation
- Prefix validation (e.g., must start with 6 for Cameroon)
- Real-time feedback as user types

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- GetX team for the powerful state management solution
- Contributors and maintainers

## Contact

Your Name - [@yourusername](https://twitter.com/yourusername)
Project Link: [https://github.com/yourusername/orangecmui](https://github.com/yourusername/orangecmui)
