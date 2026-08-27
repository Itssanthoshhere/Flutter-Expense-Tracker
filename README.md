# Expense Tracker 💰

A simple, fast, and offline-first Expense Tracker application built with Flutter. Keep track of your daily expenses, monitor your total budget, and manage your finances securely on your device.

## 🌟 Features

- **Add Expenses:** Log new expenses with a title, amount, and date.
- **Track Budget:** Automatically calculates your total expenses and displays your remaining balance from a fixed budget.
- **Local Storage:** Uses [Hive](https://pub.dev/packages/hive) for fast, secure, and offline data persistence. No internet connection required!
- **Manage Entries:** Easily delete past expenses with a confirmation prompt.
- **Beautiful UI:** A clean, responsive interface built with Material Design.

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Database:** Hive (NoSQL local storage)
- **Dependencies:** 
  - `hive` & `hive_flutter` for local database
  - `path_provider` for file system paths
  - `intl` for date formatting

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.12.0 or higher)
- Android Studio / Xcode for device emulation
- VS Code or your preferred IDE

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Itssanthoshhere/Flutter-Expense-Tracker.git
   cd Flutter-Expense-Tracker
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive Adapters** (if you make changes to the models):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Running the App Locally

To run the app on an attached device or emulator:

```bash
flutter run
```

---

## 📦 Build for Production

When you are ready to distribute your app, you can compile it into a release build.

### Android

To build a release APK file (for direct installation):
```bash
flutter build apk --release
```

To build an App Bundle (recommended for Google Play Store):
```bash
flutter build appbundle
```

### iOS

*Note: You need a Mac with Xcode and an Apple Developer account to build for iOS devices.*

To build the iOS app:
```bash
flutter build ios --release
```

---

## 📂 Project Structure

```
lib/
├── main.dart                   # App entry point & Hive initialization
├── models/
│   ├── expense_model.dart      # Expense data model
│   └── expense_model.g.dart    # Generated Hive adapter
└── screens/
    ├── home_screen.dart        # Main dashboard displaying expenses and budget
    └── add_expense_screen.dart # Form to input new expenses
```

## 📝 License

This project is open source and available under the [MIT License](LICENSE).
