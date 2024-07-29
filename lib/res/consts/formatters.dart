import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber){
    // assuming a 10 digit us phone number : (123) 4567890
    if(phoneNumber.length ==10){
      return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,6)} ${phoneNumber.substring(6)}';
    } else if(phoneNumber.length ==11){
      return '(${phoneNumber.substring(0,4)} ${phoneNumber.substring(4,7)} ${phoneNumber.substring(7)})';
    }
    // add more custom phonenumber format if needed
    return phoneNumber;
  }


  // not fully tested
  static String internationalFormatPhoneNumber(String phoneNUmber){
    // remove any non digit character from the phonenumber
    var digitsOnly = phoneNUmber.replaceAll(RegExp(r'\D'), '');

    //  extract the country code from the digits only
    String countryCode = '+${digitsOnly.substring(0,2)}';
    digitsOnly = digitsOnly.substring(2);

    // add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i=0;
    while(i< digitsOnly.length){
      int groupLength =2;
      if(i==0 && countryCode == '+1'){
        groupLength =3;
      }
      int end = i+groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if(end<digitsOnly.length){
        formattedNumber.write(' ');
      }
      i= end;
    }
    return formattedNumber.toString();
  }
}