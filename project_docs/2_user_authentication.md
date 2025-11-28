# 2. User Authentication

## Concept Overview
User Authentication verifies the identity of users accessing the app. We implemented two methods: Email/Password and Google Sign-In.

## Key Components

### 1. Authentication Methods
- **Email/Password**: Uses `FirebaseAuth.instance.createUserWithEmailAndPassword` for signup and `signInWithEmailAndPassword` for login.
- **Google Sign-In**: Uses the `google_sign_in` package to get an OAuth token from Google, which is then exchanged for a Firebase credential using `GoogleAuthProvider.credential`.

### 2. Auth State Management
We use a `Stream` to listen to authentication state changes:
```dart
FirebaseAuth.instance.authStateChanges()
```
This stream emits a `User` object when logged in and `null` when logged out.

### 3. Splash Screen Redirection
In `splash_screen.dart`, we check the current user status:
- If `User` is not null -> Navigate to **Home Screen**.
- If `User` is null -> Navigate to **Login Screen**.

### 4. Code Structure
- `AuthService`: Handles Email/Password logic.
- `GoogleAuthService`: Handles Google Sign-In logic.
- `LoginScreen` / `SignupScreen`: UI for user input.

## Review Questions & Answers
**Q: How do you handle user sessions?**
A: Firebase automatically persists the user session locally. We listen to `authStateChanges()` to detect if a user is already logged in when the app restarts.

**Q: What happens if Google Sign-In fails?**
A: We catch the error, log it to Crashlytics, and return `null`. The UI then displays an error message to the user.
