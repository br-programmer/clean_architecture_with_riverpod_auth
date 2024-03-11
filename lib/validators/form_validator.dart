class FormValidator {
  const FormValidator._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 4) {
      return 'The password is short.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (password != null && password.isNotEmpty && password != value) {
      return 'The passwords do not match.';
    }
    return null;
  }
}
