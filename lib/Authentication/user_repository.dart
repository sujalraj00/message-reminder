// repos class for user related information
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/firebase_exception.dart';
import 'package:message_reminder/Authentication/format_exception.dart';
import 'package:message_reminder/Authentication/platform_exception.dart';
import 'package:message_reminder/models/user_model.dart';


class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // function to save user data to FireStore
  Future<void>saveUserRecord(UserModel user ) async{
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on TFirebaseException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // fn to fetch user detail based on id
  Future<UserModel>fetchUserDetails() async{
    try{
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists ){
        return UserModel.fromSnapshot(documentSnapshot);
      } else{
        return UserModel.empty();
      }
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on TFormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // fn to update user data in fireStore
  Future<void>updateUserDetail(UserModel updatedUser ) async{
    try{
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on TFormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // update any field in specific user collection
  Future<void>updateSingleField(Map<String, dynamic> json ) async{
    try{
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on TFormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // fn to remove user data from fireStore
  Future<void>removeUserRecord(String userId ) async{
    try{
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on TFormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}