import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/loaders.dart';
import 'package:message_reminder/Authentication/user_repository.dart';
import 'package:message_reminder/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }
  // fetch user record
  Future<void> fetchUserRecord() async{
    try{
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch(e){
      user(UserModel.empty());
    }
    finally{
      profileLoading.value = false;
    }
  }

  // save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // convert name to first name and last name
        final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '');

        // map data
        final user = UserModel(id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName: nameParts.length > 1? nameParts.sublist(1).join(' ') : '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '');

        // save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }

  // delete acc warning
  // void deleteAccountWarningPopup() {
  //   Get.defaultDialog(
  //       contentPadding: const EdgeInsets.all(16),
  //       title: 'Delete Account',
  //       middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
  //       confirm: ElevatedButton(onPressed: ()async => deleteUserAccount() ,
  //           child: const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 24), child: Text("Delete"),
  //           )),
  //       cancel: OutlinedButton(onPressed: () => Navigator.of(Get.overlayContext!).pop(), child: const Text('Cancel'))
  //   );
  // }

  // delete user acc
  // void deleteUserAccount () async {
  //   try{
  //     TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);
  //     // first re - auth user']
  //     final auth = AuthenticationRepository.instance;
  //     final pr
  //   } catch(e){
  //
  //   }
  // }

  // re - authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser () async {}
}