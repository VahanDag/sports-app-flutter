# Sports App

![Watch the demo video](C:\Users\vdag_\Desktop\Vahan\Python\image-converter\convertedFiles\covertedGif.gif)

## Overview

This is a Flutter-based sports application that displays various football data. The app features:

- Live scores
- Upcoming match schedules
- Club information
- League standings
- Team lineups
- News related to clubs
- Market values
- And much more

The data is sourced from the free API provided by [football-data.org](https://www.football-data.org/).

## Getting Started

To start using this repository, follow the steps below:

### Prerequisites

- Flutter SDK: Ensure you have Flutter installed on your machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- A valid API key from [football-data.org](https://www.football-data.org/).

### Setup

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/sports-app.git
    cd sports-app
    ```

2. **Obtain an API key:**

    - Register on [football-data.org](https://www.football-data.org/).
    - Get your free API key.

3. **Configure the API key:**

    - Open the `football_service.dart` file located in the `lib/services/` directory.
    - Replace the placeholder with your actual API key:

    ```dart
    final String apiKey = 'YOUR_API_KEY_HERE';
    ```

### Firebase Integration

The app is integrated with Firebase for enhanced features such as "Club or Player Search". To set up Firebase:

1. **Firebase Setup:**

    - Create a project on [Firebase Console](https://console.firebase.google.com/).
    - Add your Android and iOS apps to the Firebase project.
    - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate directories:

    ```plaintext
    - android/app/google-services.json
    - ios/Runner/GoogleService-Info.plist
    ```

2. **Configure Firebase options:**

    - Open the `firebase_options.dart` file located in the `lib/` directory.
    - Replace the existing configuration with your Firebase project settings.

### Run the Application

After completing the above setup, you can run the application using the following command:

```bash
flutter run
```

### Note
The application is still under development, and new features will be added over time.

### Contribution
Contributions are welcome! Feel free to open issues or submit pull requests to help improve the app.

### Contact
For any inquiries, please contact vahandag@gmail.com