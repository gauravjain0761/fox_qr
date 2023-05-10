extension BoolExtension on bool {
  bool get not => !this;
}

bool isValidEmail(String email) {
  String emailRegex = r'^[a-zA-Z][a-zA-Z0-9._]*@[a-zA-Z]+\.[a-zA-Z]{2,}$';
  return RegExp(emailRegex).hasMatch(email);
}
