class SignupValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name is required";
    if (value.trim().length < 3) return "Enter a valid name";
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return "Password is required";
    if (value.trim().length < 6) return "Minimum 6 characters";
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) return "Confirm your password";
    if (value.trim() != password.trim()) return "Passwords do not match";
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10 || (digits.length > 10 && digits.length <= 13)) {
      return null;
    }

    return "Enter a valid phone number";
  }
}
