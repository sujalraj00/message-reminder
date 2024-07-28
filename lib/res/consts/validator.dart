import 'package:get_storage/get_storage.dart';

class TValidator{
  // username text validator
  static String? validateUserName(String? username){
    if(username == null || username.isEmpty){
      return 'username is required';
    }
    // define a regular exp pattern for username
    const pattern= r"^[a-zA-Z0-9_-]{3,20}$";;

    // create a regular exp instance from patter
    final regex = RegExp(pattern);

    // use the hashMatch method to check if the username matches the pattern
    bool isValid = regex.hasMatch(username);

    // check if username does not start or end with - _
    if(isValid){
      isValid = !username.startsWith('_') && !username.startsWith('-') && !username.endsWith('_') && !username.endsWith('-');
    }

    if(!isValid) {
      return 'username is not valid';
    }
    return null;
  }

  // empty text validation
  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required.';
    }
    return null;
  }



  //validate email
  static String? validateEmail(String? value,  ) {
    if(value == null || value.isEmpty){
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty) {
      return 'Password is required';
    }

    // check for minimum password length
    if(value.length <8){
      return 'Password must be at least 8 characters long.';
    }

    // check for uppercase letters
    if(!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // check for numbers
    if(!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // check for special characters
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }


}