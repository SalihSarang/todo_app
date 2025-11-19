## Google Authentication (Firebase + Google Sign-In)

This app uses **Google Sign-In** on top of **Firebase Authentication** to let users log in with their Google account.

### 1. Packages
- **firebase_core**: initialize Firebase.
- **firebase_auth**: handle auth state, sign-in and sign-out.
- **google_sign_in**: show Google account picker and obtain Google credentials.

### 2. Configuration Steps
1. Create a Firebase project and add an **Android** (and/or iOS) app.
2. Download and add `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) to the platform folders.
3. Enable **Google provider** in the Firebase Console under **Authentication → Sign-in method**.
4. Add the Firebase initialization code in `main.dart` (using `Firebase.initializeApp` or `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`).

### 3. Integration in Code
- `lib/app/features/user_auth/data/repositories/google_auth/google_auth.dart` contains the logic that:
  - Triggers the Google sign-in flow using `GoogleSignIn`.
  - Obtains `GoogleSignInAuthentication` tokens.
  - Converts them into a `AuthCredential` (`GoogleAuthProvider.credential`).
  - Signs in to Firebase using `FirebaseAuth.instance.signInWithCredential`.
- The resulting `User` is stored/handled in your auth layer (providers, notifiers) to update app state.

### 4. Typical Sign-In Flow
1. User taps the "Continue with Google" button in the UI.
2. App opens Google account picker via `GoogleSignIn`.
3. On success, Google returns tokens which are exchanged for Firebase credentials.
4. Firebase signs the user in and you receive a `UserCredential`.
5. Your app updates UI based on authentication state (e.g., navigate to home screen).

### 5. Error Handling & Edge Cases
- User cancels Google sign-in: return a clear error or silently ignore.
- Network errors: show a message and allow retry.
- Account disabled / invalid credentials: surface error from `FirebaseAuthException`.

### 6. Logout
- Sign out from both:
  - `FirebaseAuth.instance.signOut()`
  - `GoogleSignIn().signOut()`


