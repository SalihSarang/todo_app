## Firebase Authentication Overview

The app uses **Firebase Authentication** as the central system for creating accounts, logging in users, and managing sessions.

### 1. What Firebase Auth Provides
- **Email/password sign-up & login**.
- **Google Sign-In** and other identity providers (configured separately).
- **Secure token-based sessions** with automatic refresh.
- An easy way to listen to auth state changes (logged in / logged out).

### 2. Configuration
1. Create a Firebase project and register your app.
2. Add platform config files (`google-services.json` / `GoogleService-Info.plist`).
3. Enable desired sign-in methods in **Firebase Console → Authentication → Sign-in method**.
4. Initialize Firebase in `main.dart` using `Firebase.initializeApp` / `DefaultFirebaseOptions.currentPlatform`.

### 3. How It Is Structured in This App
- `lib/app/features/user_auth/data/repositories/fire_base_auth/`:
  - `auth_service.dart`: low-level interaction with `FirebaseAuth` (sign-in, sign-up, sign-out, get current user, etc.).
  - `login_user.dart`: encapsulated logic for logging in with email/password.
  - `register_user.dart`: encapsulated logic for registering a new user.
  - `user_repository.dart`: higher-level abstraction around authentication-related operations.
- `lib/app/features/user_auth/business/`:
  - Notifiers/providers that expose authentication state to the UI.

### 4. Typical Email/Password Flow
**Sign Up**
1. Validate user input (email, password, name, etc.).
2. Call repository `registerUser(...)` which internally uses `FirebaseAuth.createUserWithEmailAndPassword`.
3. Optionally create an associated user document in Firestore (e.g., profile data).
4. Update app state and navigate to the main/home screen.

**Login**
1. Validate email & password.
2. Call repository `loginUser(...)` which internally uses `FirebaseAuth.signInWithEmailAndPassword`.
3. Handle `FirebaseAuthException` for invalid credentials.
4. On success, store/update the user in providers and navigate to the main/home screen.

### 5. Auth State Listening
- Common pattern:
  - Subscribe to `FirebaseAuth.instance.authStateChanges()` or `idTokenChanges()`.
  - Update providers/notifiers when user signs in or out.
  - Use this to show splash → login → home based on auth state.

### 6. Sign Out & Delete Account
- **Sign out**:
  - Call sign-out in `auth_service.dart` / `user_repository.dart` (internally `FirebaseAuth.instance.signOut()`).
- **Delete account**:
  - Call `currentUser.delete()` from Firebase Auth (may require recent re-auth).
  - Optionally remove related user data from Firestore/Storage via a repository function.


