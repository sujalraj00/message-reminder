import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_reminder/res/consts/formatters.dart';


class UserModel {
  // keep those values final which you don't want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture
  });

  // Helper function to get the full name
  String get fullName => '$firstName $lastName';

  // helper function to format phoneNumber
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

// static fun to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

// static fun to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // add "cwt_"  prefix
    return usernameWithPrefix;
  }

// static fun to create an empty user model
  static UserModel empty() =>
      UserModel(id: '',
          username: '',
          email: '',
          firstName: '',
          lastName: '',
          phoneNumber: '',
          profilePicture: '');

// convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

// factory method to create a UserModel from a firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(id: document.id,
          username: data['UserName'] ?? '',
          email:data['Email'] ?? '',
          firstName:data['FirstName'] ?? '',
          lastName:data['LastName'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else{
      return UserModel.empty();
    }
  }


}
