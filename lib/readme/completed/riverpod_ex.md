## Riverpod State Management in This Project

This project uses **Riverpod** for managing state such as authentication, todos, and user profile data.

### 1. What Riverpod Is Doing Here
- Provides a **central place** to store and read app state (auth status, todo list, user profile).
- Allows widgets to **listen to providers** and rebuild only when the relevant state changes.
- Keeps business logic out of UI widgets by using **notifiers** and **providers**.

### 2. Where to Look in the Code
- `app/features/todo/business/`:
  - `todo_provider.dart`: exposes providers for reading/updating todo-related state.
  - `todo_notifier.dart`: contains the core todo logic (add, update, delete, load).
- `app/features/user/business/`:
  - `user_details_provider.dart` / `user_details_notifier.dart`: manage user profile data.
- `app/features/user_auth/business/`:
  - `user_providre.dart`: handles auth-related state (current user, loading, errors).

### 3. Typical Pattern
1. **Define State / Notifier**
   - Create a model (e.g., `TodoModel`, `UserModel`).
   - Write a notifier (e.g., `TodoNotifier`) extending `StateNotifier<List<TodoModel>>` (or another state type).
2. **Expose a Provider**
   - Create a `StateNotifierProvider` / `Provider` / `FutureProvider` that exposes the notifier/state.
3. **Use in UI**
   - In widgets, use `ref.watch(provider)` to read state.
   - Use `ref.read(provider.notifier)` (or `ref.read(provider)` for simple providers) to call actions (add todo, log out, update profile, etc.).

### 4. Benefits for This App
- **Separation of concerns**: UI widgets are mostly responsible for layout and user interaction, while logic lives in notifiers/repositories.
- **Testability**: Notifiers and repositories can be tested without UI.
- **Scalability**: Easy to add more features (new providers/notifiers) without tightly coupling everything.


