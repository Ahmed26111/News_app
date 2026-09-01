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

  static String getDifferenceFormateDateTime(String dateTime) {
    DateTime? date = DateTime.tryParse(dateTime);
    if(date == null)return "";
    final diff = DateTime.now().difference(date);

    if(diff.inSeconds < 60){
      return "${diff.inSeconds} seconds ago";
    }
    else if(diff.inMinutes < 60){
      return "${diff.inMinutes} minutes ago";
    }
    else if(diff.inHours < 24){
      return "${diff.inHours} hours ago";
    }
    else if(diff.inDays < 7){
      return "${diff.inDays} days ago";
    }
    else if(diff.inDays < 30){
      return "${diff.inDays ~/ 7} weeks ago";
    }
    else if(diff.inDays < 365){
      return "${diff.inDays ~/ 30} months ago";
    }
    else{
      return "${diff.inDays ~/ 365} years ago";
    }
  }
}
