# Kiwis Flutter

A Flutter application with advanced mapping and location features using VietMap integration.
[Kiwis Demo](https://drive.google.com/file/d/1Yz9dKokiMr3sxB0LPazyc3M6ms6RZXtX/view?usp=sharing)

## Features

### Map Services
- Custom map implementation using VietMap
- Real-time location tracking
- Custom markers with user avatars
- Route drawing and navigation
- Polyline tracking with auto-removal
- Route recalculation when deviating
- Location sharing in groups
- Search locations with autocomplete

### Location Services
- High-accuracy location tracking
- Background location updates
- Distance calculation
- Location permissions handling
- GPS status monitoring

### Core Features
- Firebase integration (Auth, Firestore, Messaging, Crashlytics)
- Multi-language support
- Responsive design
- File upload handling
- API integration with caching
- Socket.IO implementation
- Local notifications

### UI Components
- Custom markers
- Search with debouncing
- Loading indicators
- Snackbar notifications
- Responsive layouts
- Custom buttons and form fields

## Technical Specifications

### Dependencies
- **Maps & Location**: 
  - vietmap_flutter_gl
  - vietmap_flutter_plugin
  - geolocator
  - location

- **State Management**:
  - GetX
  - Get It (Dependency Injection)

- **Backend Integration**:
  - Firebase Core
  - Firebase Auth
  - Firebase Messaging
  - Cloud Firestore
  - Socket.IO

- **UI/UX**:
  - Google Fonts
  - Flutter SVG
  - Cached Network Image
  - Pull to Refresh
  - Crystal Navigation Bar
  - Animated Snackbar

### Architecture
- GetX pattern for state management
- Service-based architecture
- Repository pattern for data handling
- Base API implementation with error handling
- Custom utilities for responsive design

### Key Services
- MapService: Handles all map-related operations
- GeolocatorService: Manages location tracking
- AuthService: Handles authentication
- NotificationService: Manages push notifications

## Setup Requirements
- Flutter SDK
- Firebase project configuration
- VietMap API key
- Environment file (.env) configuration

## Environment Variables 

## Installation & Setup Guide

### Prerequisites
1. Install Flutter SDK (version ^3.5.1)
2. Install Android Studio or VS Code
3. Setup your preferred IDE with Flutter and Dart plugins
4. A physical device or emulator for testing

### Step 1: Clone Repository
bash
git clone [repository-url]
cd kiwis_flutter

### Step 2: Environment Setup
1. Create a `.env` file in the root directory:
env
VIETMAP_API_KEY=your_vietmap_api_key


2. Firebase Setup:
- Create a new Firebase project
- Download `google-services.json` for Android
- Download `GoogleService-Info.plist` for iOS
- Place these files in their respective directories:
  ```
  android/app/google-services.json
  ios/Runner/GoogleService-Info.plist
  ```

### Step 3: Install Dependencies
bash
```
flutter pub get
```

### Step 4: iOS Setup
bash
```
cd ios
pod install
cd ..
```

### Step 5: Run the App
bash
```
flutter run
```

## Development Guidelines

### Code Structure
```
lib/
├── core/ # Core functionality and utilities
├── models/ # Data models
├── services/ # Service classes
├── views/ # UI screens
├── widgets/ # Reusable widgets
└── main.dart # Entry point```
