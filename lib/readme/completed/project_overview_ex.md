## Project Overview & Other Important Concepts

This README summarizes other key concepts used in the app in addition to Firebase Auth, Google Auth, Firestore, Cloudinary, and Riverpod.

### 1. Folder & Feature Structure
- `app/features/` is split by **feature**:
  - `splash_screen/`: initial loading/auth check screen.
  - `todo/`: all todo logic (models, repositories, notifiers, UI screens & widgets).
  - `user/`: user profile (image, name, IDs, logout).
  - `user_auth/`: login/signup screens, auth repositories, and related utilities.
- Each feature contains:
  - `data/`: models and repositories (data access).
  - `business/`: providers/notifiers (Riverpod state management).
  - `presentation/`: screens and widgets (UI).
  - `utils/`: small helper functions specific to that feature.

### 2. Navigation
- `app/utils/functions/navigator.dart` provides helper functions for navigation.
- Common pattern:
  - Use central navigation helpers to push/pop routes, making navigation easier to change later and keeping widgets clean.

### 3. Form Validation & Helpers
- `app/features/todo/utils/` and `app/features/user_auth/utils/` contain validation logic:
  - `form_validation.dart`, `validate_form.dart`, `login_screen_validation.dart`, `signup_validations.dart`, etc.
- These helpers keep validation logic out of widgets and make it reusable:
  - Check required fields, email format, password strength, etc.

### 4. Unique IDs and Models
- `app/features/todo/utils/unique_id.dart`:
  - Generates unique IDs for todos (or other entities) when creating new items.
- Models like `TodoModel`, `UserModel`, and `ImageModel` live under `data/model/`:
  - Responsible for serializing/deserializing data to/from maps (for Firestore or other storage).

### 5. Image Picking & Uploading
- `app/features/user/utils/image_pickcer/image_pickcer.dart`:
  - Handles picking images from gallery/camera.
- `app/features/user/data/repositories/pick_and_upload_img.dart`:
  - Connects image picking with upload (e.g., to Cloudinary or another backend).
  - Returns an image URL that can be stored in a user profile document.

### 6. Reusable UI Widgets
- Under various `presentation/widgets/` directories you’ll find reusable components:
  - Custom buttons, text fields, loaders, app bars, empty/error views, etc.
- Goal:
  - Centralize common UI patterns, keep screens lean, and ensure consistent styling across the app.


