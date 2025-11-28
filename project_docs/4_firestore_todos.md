# 4. Firestore Database for To-Dos

## Concept Overview
This module handles the creation, reading, updating, and deletion (CRUD) of task data using Cloud Firestore. It ensures data is private to each user and synchronized in real-time across devices.

## Key Components

### 1. Database Structure
We use a subcollection pattern for privacy and organization:
`users/{userId}/todos/{todoId}`
- **Collection**: `users`
- **Document**: `userId` (The authenticated user)
- **Subcollection**: `todos`
- **Document**: `todoId` (The individual task)

This structure automatically ensures that a user can only query their own tasks (assuming proper security rules).

### 2. Data Model (`TodoModel`)
The `TodoModel` class maps Dart objects to Firestore documents:
- `id`: Document ID.
- `title`: Task title.
- `details`: Task description.
- `isCompleted`: Boolean status.
- `date` & `time`: Due date/time.

### 3. Real-time Sync (`Stream`)
Instead of fetching data once (`get()`), we use a `Stream` (`snapshots()`):
```dart
_userTodoCollection(userId).snapshots().map(...)
```
This allows the app to listen for changes. If a task is added/updated on another device, the stream emits a new list of todos, and the UI updates instantly without a refresh.

### 4. CRUD Operations
- **Create**: `add()` creates a new document with an auto-generated ID.
- **Read**: `snapshots()` streams the list of documents.
- **Update**: `update()` modifies specific fields (e.g., `isCompleted`).
- **Delete**: `delete()` removes the document.

## Review Questions & Answers
**Q: Why use a subcollection instead of a top-level `todos` collection?**
A: Subcollections (`users/{uid}/todos`) naturally group data by user, making it easier to write security rules ("users can only read/write their own subcollections") and preventing queries from accidentally leaking other users' data.

**Q: What is the difference between `get()` and `snapshots()`?**
A: `get()` fetches the data once (like a REST API call). `snapshots()` opens a persistent connection (WebSocket) and pushes updates whenever the database changes.
