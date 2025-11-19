## Cloud Firestore Usage

This app can use **Cloud Firestore** as a NoSQL document database for storing todos, user profiles, and other app data.

### 1. Firestore Basics
- Data is stored in **collections** → **documents** → **subcollections**.
- Documents are key–value maps (fields can be strings, numbers, arrays, maps, timestamps, etc.).
- Access is done via the Firebase client SDK (`cloud_firestore` package in Flutter).

### 2. Configuration
1. Enable **Cloud Firestore** in the Firebase Console.
2. Set up basic **security rules** (start in test mode only during development).
3. Ensure Firebase is initialized in `main.dart` before using Firestore.
4. Add the `cloud_firestore` dependency to `pubspec.yaml`.

### 3. How to Organize Firestore Code in This App
- Recommended pattern (aligns with existing structure):
  - `data/model/`: Dart models (e.g., `TodoModel`, `UserModel`) with `fromMap` / `toMap` or `fromJson` / `toJson`.
  - `data/repositories/`: Firestore repositories that:
    - Read and write documents.
    - Convert between Firestore maps and app models.
  - `business/` (providers/notifiers):
    - Use repositories to fetch/update data.
    - Expose streams or state to the UI.

### 4. Typical Todo Example (Conceptual)
- **Collection**: `todos`
- **Document fields**:
  - `id`: unique ID (could match Firestore doc ID or app-generated).
  - `title`: string.
  - `description`: string.
  - `isCompleted`: boolean.
  - `createdAt`: timestamp.
- **Operations**:
  - Add a document when creating a todo.
  - Update fields when editing or marking complete.
  - Listen to a query (e.g., `todos` ordered by `createdAt`) to update UI in real-time.

### 5. Reading & Writing (High-Level)
- **Create**: `collection('todos').add(todo.toMap())` or `doc(id).set(...)`.
- **Read single**: `collection('todos').doc(id).get()`.
- **Read list**: `collection('todos').orderBy('createdAt').snapshots()` (stream).
- **Update**: `collection('todos').doc(id).update({...})`.
- **Delete**: `collection('todos').doc(id).delete()`.

### 6. Security & Indexing
- Use Firestore rules to:
  - Restrict access so users can only read/write their own documents.
  - Enforce field validation where possible.
- Create composite indexes in the console if Firestore requests them for complex queries.


