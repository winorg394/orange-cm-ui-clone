# UI Design Guidelines

## Design System

### Colors

```dart
// Primary Colors
static const Color primary = Color(0xFFFF6B00);     // Orange
static const Color secondary = Color(0xFF1A1A1A);   // Almost Black

// Neutral Colors
static const Color background = Colors.white;
static const Color surface = Color(0xFFF5F5F5);     // Light Gray
static const Color textPrimary = Color(0xFF1A1A1A); // Dark Gray
static const Color textSecondary = Color(0xFF757575); // Medium Gray

// Status Colors
static const Color error = Color(0xFFDC3545);       // Red
static const Color success = Color(0xFF28A745);     // Green
```

### Typography

```dart
// Headings
static const TextStyle h1 = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1.2,
);

static const TextStyle h2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  height: 1.3,
);

// Body Text
static const TextStyle body1 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  height: 1.5,
);

static const TextStyle body2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  height: 1.4,
);
```

### Spacing

```dart
// Spacing Scale
static const double spacing0 = 0;
static const double spacing1 = 4;
static const double spacing2 = 8;
static const double spacing3 = 12;
static const double spacing4 = 16;
static const double spacing5 = 24;
static const double spacing6 = 32;
static const double spacing7 = 40;
static const double spacing8 = 48;
```

## Components

### Buttons

1. **Primary Button**
   - Orange background
   - White text
   - 16px border radius
   - No elevation

2. **Secondary Button**
   - White background
   - Orange text
   - 16px border radius
   - 1px orange border

### Input Fields

1. **Text Input**
   - Light gray background
   - 16px border radius
   - No border in normal state
   - Orange border when focused

2. **Search Input**
   - White background
   - Gray border
   - Search icon prefix
   - Clear button when not empty

### Bottom Sheets

1. **Standard Bottom Sheet**
   - White background
   - Rounded top corners (24px)
   - Drag indicator
   - Close button

### Lists

1. **List Items**
   - 16px vertical padding
   - 16px horizontal padding
   - Optional leading icon
   - Optional trailing icon

## Animations

### Duration Guidelines

```dart
// Animation Durations
static const Duration shortest = Duration(milliseconds: 150);
static const Duration short = Duration(milliseconds: 250);
static const Duration medium = Duration(milliseconds: 350);
static const Duration long = Duration(milliseconds: 500);
```

### Common Animations

1. **Fade**
   - Use for appearing/disappearing elements
   - Duration: short
   - Curve: easeInOut

2. **Scale**
   - Use for emphasis
   - Duration: shortest
   - Curve: easeOut

3. **Slide**
   - Use for navigation
   - Duration: medium
   - Curve: easeInOut

## Responsive Design

### Breakpoints

```dart
// Screen Breakpoints
static const double mobileBreakpoint = 600;
static const double tabletBreakpoint = 900;
static const double desktopBreakpoint = 1200;
```

### Layout Guidelines

1. **Mobile**
   - Single column layout
   - Full-width components
   - Bottom sheet for additional content

2. **Tablet**
   - Two column layout where appropriate
   - Side sheet instead of bottom sheet
   - Larger touch targets

## Accessibility

### Guidelines

1. **Color Contrast**
   - Minimum 4.5:1 for normal text
   - Minimum 3:1 for large text
   - Test all color combinations

2. **Touch Targets**
   - Minimum size: 48x48 pixels
   - Adequate spacing between targets
   - Clear visual feedback

3. **Text Scaling**
   - Support system font scaling
   - Maintain readability at larger sizes
   - Use scalable units (sp)
