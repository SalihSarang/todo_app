# 5. Firebase Storage Integration

## Concept Overview
Firebase Storage is used to store user-generated content like profile pictures. It is built for storing and serving large files (images, audio, video).

## Key Components

### 1. Upload Process
1.  **Selection**: The user selects an image using `image_picker`.
2.  **Reference**: We create a reference to the file location:
    ```dart
    final ref = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
    ```
3.  **Upload**: We upload the file bytes using `putFile`:
    ```dart
    await ref.putFile(file);
    ```
4.  **Download URL**: After a successful upload, we get the public URL:
    ```dart
    final url = await ref.getDownloadURL();
    ```
5.  **Database Update**: This URL is saved to the user's Firestore profile (`imgURL`).

### 2. Displaying Images
We use the standard `NetworkImage` widget (or `CachedNetworkImage` for better performance) to display the image using the URL stored in Firestore.

### 3. Security Rules
Security rules determine who can read/write files. A basic rule for user profiles would be:
```
match /profile_images/{userId}.jpg {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
```
This ensures users can only overwrite their own profile picture.

## Review Questions & Answers
**Q: Where are the images actually stored?**
A: They are stored in a Google Cloud Storage bucket associated with the Firebase project.

**Q: Why do we save the URL in Firestore?**
A: Firebase Storage is a file system, not a database. To efficiently display the image in the app (e.g., in a list of users or on the profile screen), we need a reference (the URL) stored alongside the user's other data in the database.
