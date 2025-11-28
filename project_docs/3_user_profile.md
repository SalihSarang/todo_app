# 3. User Profile Management

## Concept Overview
This feature allows users to view and manage their personal information, such as name, email, address, and profile picture.

## Key Components

### 1. Data Model (`UserModel`)
We defined a `UserModel` class to structure user data:
- `uid`: Unique User ID from Firebase Auth.
- `name`: Display name.
- `email`: Email address.
- `imgURL`: URL of the profile picture in Firebase Storage.
- `address`: Physical address (added recently).

### 2. Firestore Storage
User data is stored in a `users` collection in Firestore:
`users/{userId}` document contains the fields above.

### 3. State Management (`ProfileNotifier`)
We use Riverpod's `StateNotifier` to manage the profile state:
- Fetches user data on load.
- Provides methods like `updateName`, `updateAddress`, and `updateImageURL`.
- Optimistically updates the UI while saving to Firestore in the background.

### 4. Profile Picture Upload
- **Image Picker**: Selects an image from the gallery.
- **Firebase Storage**: Uploads the file to `profile_images/{userId}.jpg`.
- **URL Update**: The download URL is retrieved and saved to the `imgURL` field in Firestore.

## Review Questions & Answers
**Q: Why do we store user data in Firestore instead of just using `FirebaseAuth.currentUser`?**
A: `FirebaseAuth` only stores basic info (email, name, photo). Firestore allows us to store custom fields like `address` and gives us more control over the data structure.

**Q: How is the profile picture updated?**
A: We pick the image, upload it to Firebase Storage, get the download URL, and then update the `imgURL` field in the user's Firestore document.
