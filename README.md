# Expense Checker 💰

A comprehensive personal expense tracking Flutter application that helps you monitor your daily spending habits with beautiful charts and intuitive transaction management.

## ✨ Features

- **Transaction Management**: Add, view, and delete expense transactions with ease
- **Visual Analytics**: Interactive weekly spending chart showing daily expense breakdown
- **Date Selection**: Pick specific dates for your transactions
- **Adaptive UI**: Platform-specific design elements for iOS and Android
- **Responsive Design**: Optimized for both portrait and landscape orientations
- **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux

## 📱 Screenshots

### Main Features
- Clean and modern Material Design interface
- Weekly expense chart with bar visualization
- Scrollable transaction list with swipe-to-delete functionality
- Modal bottom sheet for adding new transactions
- Landscape mode with chart toggle option

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point and main UI
├── models/
│   └── transaction.dart      # Transaction data model
└── widgets/
    ├── adaptive_button.dart  # Platform-adaptive button widget
    ├── chart_bar.dart       # Individual chart bar component
    ├── chart.dart           # Weekly spending chart widget
    ├── new_transaction.dart  # Add transaction modal
    ├── transaction_item.dart # Individual transaction list item
    └── transaction_list.dart # Transaction list container
```

### Key Components
- **Transaction Model**: Stores transaction data (title, amount, date, ID)
- **Chart Widget**: Displays last 7 days of spending with visual bars
- **Responsive Layout**: Different layouts for portrait/landscape orientations
- **Platform Detection**: iOS-style navigation and Android Material Design

## 🛠️ Technologies Used

- **Flutter SDK**: Cross-platform mobile development framework
- **Dart**: Programming language
- **Material Design**: UI design system
- **Cupertino**: iOS-style widgets
- **Intl Package**: Internationalization and date formatting

## 🏛️ State Management

This application uses **Flutter's Built-in State Management** with `StatefulWidget` and `setState()` for a clean, simple, and effective approach suitable for small to medium-sized applications.

### State Management Architecture

#### 1. **Local Widget State**
- Each widget manages its own internal state using `StatefulWidget`
- `setState()` is used to trigger UI rebuilds when data changes
- Perfect for simple state changes like form inputs, toggles, and UI interactions

#### 2. **State Lifting & Prop Drilling**
- Main application state is managed in the root `MyHomePage` widget
- State is passed down to child widgets via constructor parameters
- Callback functions are passed down to allow child widgets to modify parent state

### Key State Components

#### Main Application State (`_MyHomePageState`)
```dart
class _MyHomePageState extends State<MyHomePage> {
  // Core data state
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  
  // Computed state (getters)
  List<Transaction> get _recentTransactions { ... }
  
  // State mutation methods
  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }
  
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }
}
```

#### Component-Level State Examples

**1. New Transaction Form (`NewTransaction`)**
- Manages form input controllers and validation state
- Handles date picker state
- Uses widget lifecycle methods (`initState`, `dispose`)

**2. Transaction Item (`TransactionItem`)**
- Manages random color generation for transaction avatars
- Initializes color state in `initState()` for consistent UI

**3. Chart Toggle (Landscape Mode)**
- Simple boolean state for showing/hiding chart in landscape orientation
- Responsive UI state management based on device orientation

### State Flow Pattern

```
User Action → Widget Event → Callback Function → setState() → UI Rebuild
```

**Example Flow:**
1. User taps "Add Transaction" button
2. `startAddTransaction()` method called
3. Modal bottom sheet opens with `NewTransaction` widget
4. User fills form and submits
5. `_addTransaction()` callback executed
6. `setState()` called to update `_userTransactions` list
7. UI rebuilds to show new transaction in list and chart

### Data Flow Architecture

```
MyHomePage (Root State)
├── transactions: List<Transaction>
├── showChart: bool
├── 
├── Chart Widget
│   ├── receives: recentTransactions
│   └── displays: weekly spending visualization
├── 
├── TransactionList Widget
│   ├── receives: userTransactions, deleteTx callback
│   └── renders: individual TransactionItem widgets
├── 
└── NewTransaction Widget (Modal)
    ├── manages: form state internally
    ├── receives: addTransaction callback
    └── triggers: parent state update on submit
```

### Benefits of This Approach

✅ **Simplicity**: Easy to understand and debug
✅ **Performance**: Efficient for small to medium data sets
✅ **Flutter Native**: Uses built-in Flutter patterns
✅ **Minimal Dependencies**: No external state management libraries needed
✅ **Clear Data Flow**: Explicit prop passing makes data flow transparent

### State Persistence

Currently, the application uses **in-memory state** which means:
- Data is lost when the app is closed
- Perfect for demonstration and development
- Ready for easy integration with persistent storage solutions

### Future State Management Considerations

For scaling this application, consider these state management solutions:

| Solution | Best For | Implementation Effort |
|----------|----------|----------------------|
| **Provider** | Medium apps with shared state | Low |
| **Riverpod** | Type-safe, modern Provider alternative | Medium |
| **Bloc/Cubit** | Complex business logic, testing | High |
| **GetX** | Rapid development, minimal boilerplate | Low |
| **Redux** | Predictable state, time-travel debugging | High |

### Adding Persistence

To add data persistence, you could integrate:
- **SharedPreferences**: Simple key-value storage
- **SQLite (sqflite)**: Local database
- **Hive**: Lightweight, fast NoSQL database
- **Firebase Firestore**: Cloud-based real-time database

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 2.18.6 < 3.0.0)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/PyaeSonePhyoe4545/expense_checker.git
   cd expense_checker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: API 21 (Android 5.0)
- Target SDK: Latest available
- Gradle configuration included

#### iOS
- iOS 11.0+
- Xcode project configuration included
- Info.plist configured

#### Web
- Web support enabled
- Responsive design for desktop browsers

#### Desktop (Windows/macOS/Linux)
- Desktop support for all major platforms
- Native window management

## 📋 Usage

### Adding Transactions
1. Tap the floating action button (+) or the add icon in the app bar
2. Enter transaction title and amount
3. Select a date using the date picker
4. Tap "Add Transaction" to save

### Viewing Analytics
- The chart displays your spending for the last 7 days
- Each bar represents daily spending
- In landscape mode, toggle between chart and transaction list

### Managing Transactions
- Scroll through your transaction history
- Swipe or tap delete to remove transactions
- Transactions are automatically sorted by date

## 🎨 Customization

### Fonts
The app uses custom fonts located in `assets/fonts/`:
- **Quicksand**: Primary app font (Light, Regular, Medium, Bold)
- **OpenSans**: App bar and emphasis text (Regular, Bold)

### Theme
- Primary color: Purple
- Accent color: Amber
- Error color: Red
- Custom font family integration

### Assets
- **Images**: Waiting state illustration (`assets/images/waiting.png`)
- **Icons**: Platform-specific app icons included

## 🔧 Development

### Running Tests
```bash
flutter test
```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### Desktop
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|--------|
| Android  | ✅ | Full support with Material Design |
| iOS      | ✅ | Cupertino design elements |
| Web      | ✅ | Responsive web interface |
| Windows  | ✅ | Native desktop application |
| macOS    | ✅ | Native desktop application |
| Linux    | ✅ | Native desktop application |

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**PyaeSonePhyoe4545**
- GitHub: [@PyaeSonePhyoe4545](https://github.com/PyaeSonePhyoe4545)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the UI guidelines
- The Flutter community for continuous support

---

**Happy Expense Tracking! 💸**
