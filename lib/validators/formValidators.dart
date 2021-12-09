import 'package:flutter/cupertino.dart';
import 'package:o_travel/screens/localization/const.dart';



extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isPhoneValid() {
    return RegExp(r'^(?:[+])?[0-9]{10}$').hasMatch(this);
  }

  bool isUsernameValid() {
    return RegExp(r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$').hasMatch(this);
  }

  bool isValidName(){
    return RegExp('^[a-zA-Z]+(([\',. -][a-zA-Z ])?[a-zA-Z]*)*\$').hasMatch(this);
  }
}








String phoneValidator(String value,BuildContext context){
  if (value == null || value.isEmpty) {
    return getTranslated(context, 'phone_number_cannot_empty');
  } else if (value.isPhoneValid())
    return '';
  else
    return getTranslated(context,'please_enter_valid_phone');
}

String passwordValidator(String value,BuildContext context){
  if (value.isEmpty)
    return getTranslated(context,'password_must_not_be_empty');
  else if (value.length < 8)
    return getTranslated(context,'password_must_be_greater');
  else
    return '';
}
String notEmptyValidator(String value,BuildContext context){
  if (value.isEmpty)
    return getTranslated(context,'username_cannot_be_empty');
  else
    return '';
}

String passwordConfirmationValidator(String value,String password,BuildContext context){
  if (value != password)
    return getTranslated(context,'password_do_not_match');
  else if (value.length < 8)
    return getTranslated(context,'password_must_be_greater');
  else
    return '';
}

String usernameValidator(String value,BuildContext context){
  if (value == null || value.length <=0) {
    return getTranslated(context,'username_cannot_be_empty');
  } else if (value.length < 7)
    return getTranslated(context,'username_must_be_greater');
  else if (value.isUsernameValid())
    return '';
  else
    return getTranslated(context,'please_enter_valid_username');
}

String emailValidator(String value,BuildContext context){
  if (value.isEmpty)
    return getTranslated(context,'email_cannot_be_empty');
  else if (value.isValidEmail())
    return '';
  else
    return getTranslated(context,'please_correct_email_format');
}

String commentValidator(String value,BuildContext context){
  if(value.length <=0)
    return getTranslated(context,'comment_must_not_be_empty');
  else
      return '';

}