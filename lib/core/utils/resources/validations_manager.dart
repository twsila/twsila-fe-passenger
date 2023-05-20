class AppValidations {
  static bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static checkIFAllZero(String text) {
    String textWithoutDashes = '';
    textWithoutDashes = text.replaceAll('/-/', "");
    double? parsed = double.tryParse(textWithoutDashes);
    if (textWithoutDashes == '' || (parsed != null && parsed <= 0)) {
      return true;
    } else {
      return false;
    }
  }
}
