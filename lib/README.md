# Orange Cameroon Mobile App - Source Code Structure

This directory contains the main source code of the Orange Cameroon Mobile App, following Clean Architecture principles with GetX for state management and TDD approach.

## Directory Structure

```
lib/
├── app/                    # Application Layer
│   ├── bindings/          # GetX Dependency Injection
│   ├── data/              # Data Layer
│   │   ├── models/        # Data Models
│   │   ├── providers/     # Data Providers/Sources
│   │   └── repositories/  # Repository Implementations
│   ├── domain/            # Domain Layer
│   │   ├── entities/      # Business Entities
│   │   ├── repositories/  # Repository Interfaces
│   │   └── usecases/     # Business Use Cases
│   ├── modules/           # Feature Modules
│   │   ├── auth/         # Authentication Module
│   │   ├── home/         # Home Module
│   │   └── profile/      # Profile Module
│   ├── routes/            # App Routes
│   └── utils/             # Utilities
├── core/                  # Core Functionality
│   ├── constants/         # App Constants
│   ├── theme/            # App Theme
│   ├── network/          # Network Handling
│   └── widgets/          # Common Widgets
└── main.dart             # Entry Point
```

## Architecture Overview

The application follows Clean Architecture principles with three main layers:

1. **Presentation Layer (UI)**
   - Views/Pages
   - Controllers (GetX)
   - Bindings

2. **Domain Layer**
   - Entities
   - Repository Interfaces
   - Use Cases

3. **Data Layer**
   - Models
   - Repository Implementations
   - Data Sources/Providers

## Test-Driven Development (TDD)

Each feature follows the TDD cycle:
1. Write failing test
2. Write minimal code to pass
3. Refactor
4. Repeat

Test directories mirror the source code structure:
```
test/
├── app/
│   ├── data/
│   ├── domain/
│   └── modules/
└── core/
```

## GetX Implementation

- **State Management**: Using GetX controllers
- **Dependency Injection**: Using GetX bindings
- **Route Management**: Using GetX navigation
- **Reactive Programming**: Using Rx variables and streams
