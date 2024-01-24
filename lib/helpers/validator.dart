class Validator {
  const Validator();
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }
}
