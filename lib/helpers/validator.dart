
import 'package:flutter/cupertino.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Validator {
  final BuildContext context;
  Validator(this.context);
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).emailRequired;
    }
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (!emailRegExp.hasMatch(value)) {
      return AppLocalizations.of(context).invalidEmail;
    }

    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return AppLocalizations.of(context).passwordRequired;
    }
    if (password.length < 6) {
      return AppLocalizations.of(context).passwordLength;
    }
    return null;
  }

  String? validateRetypedPassword(String retypedPassword, String password){
    if(retypedPassword.isEmpty){
      return AppLocalizations.of(context).retypedPasswordRequired;
    }
    if(retypedPassword != password){
      return AppLocalizations.of(context).retypedPasswordMatch;
    }
    return null;
  }
}
