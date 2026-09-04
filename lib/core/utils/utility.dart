abstract class Utility {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#_-])[A-Za-z\d@$!%*?&#_-]{8,}$')
        .hasMatch(password);
  }

  static bool isContainSpecialCharacter(String password) {
    return RegExp(r'[@$!%*?&#_-]').hasMatch(password);
  }

  static bool isContainLowerCaseCharacter(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  static bool isContainUpperCaseCharacter(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool isContainDigitCharacter(String password) {
    return RegExp(r'\d').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

}
