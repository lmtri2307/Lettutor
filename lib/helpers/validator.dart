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

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRetypedPassword(String retypedPassword, String password){
    if(retypedPassword.isEmpty){
      return 'Retyped password is required';
    }
    if(retypedPassword != password){
      return 'Retyped password must match password';
    }
    return null;
  }
}
