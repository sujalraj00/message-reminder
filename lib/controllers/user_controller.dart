import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/loaders.dart';
import 'package:message_reminder/Authentication/network_manager.dart';
import 'package:message_reminder/Authentication/re_auth_user_login_form.dart';
import 'package:message_reminder/Authentication/user_repository.dart';
import 'package:message_reminder/models/user_model.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/res/screens/login_screen.dart';
import 'package:message_reminder/widgets/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final imageUploading = false.obs;
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
      // first update Rx user and then check user data is already stored. if not store new data
      await fetchUserRecord();

      // if no record stored already
      if(user.value.id.isEmpty){
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
              lastName: nameParts.length > 1
                  ? nameParts.sublist(1).join(' ')
                  : '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '');

          // save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }

  // delete acc warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(16),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
        confirm: ElevatedButton(onPressed: ()async => deleteUserAccount() ,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24), child: Text("Delete"),
            )),
        cancel: OutlinedButton(onPressed: () => Navigator.of(Get.overlayContext!).pop(), child: const Text('Cancel'))
    );
  }

  // delete user acc
  void deleteUserAccount () async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);
      // first re - auth user']
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        // re - verify auth email
        if(provider == 'google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if(provider == 'password'){
          TFullScreenLoader.stopLoading();
          Get.offAll(()=> const ReAuthLoginForm());
        }
      }
    } catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // re - authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser () async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      if(!reAuthFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount;
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

// upload profile image
  uploadUserProfilePicture() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null){
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // update user image record
        Map<String, dynamic> json ={'ProfilePicture' : imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile image has been updated');
      }

    } catch(e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    }
    finally{
      imageUploading.value = false;
    }
  }
}