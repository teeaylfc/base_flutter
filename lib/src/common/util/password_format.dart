

class PasswordFormat {
  static  checkPassword(String pass)  {
    final validCharacters = RegExp(r"^[a-zA-Z0-9]+$");
    bool check = validCharacters.hasMatch(pass); // true
    return check;
  }
}
