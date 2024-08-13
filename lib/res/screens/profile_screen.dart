import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/user_controller.dart';
import 'package:message_reminder/res/consts/shimmer_effect.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/res/helper/show_snackbar.dart';
import 'package:message_reminder/widgets/circular_image.dart';
import 'package:message_reminder/widgets/profile_menu.dart';
import 'package:message_reminder/widgets/section_heading.dart';
import 'package:message_reminder/widgets/t_appbar.dart';

class ProfileScreen extends StatelessWidget {
 const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final _dateOfBirthKey = 'dateofBirth';
    final genderKey = 'gender';
    final _storage = GetStorage();
   // final dateofBirth = _storage.read(_dateOfBirthKey);
   //  @override
   //  void onInit() {
   //   // super.onInit();
   //    // Load the saved date of birth when the controller is initialized
   //    DateTime? savedDate = _storage.read(_dateOfBirthKey);
   //    if (savedDate != null) {
   //      dateofBirth.value = savedDate;
   //    }
   //  }

    // Initialize date of birth
    final dateofBirth = Rx<DateTime?>(null);
    final savedDate = _storage.read(_dateOfBirthKey);
    final gender = Rx<String>('Not Set');

    List<String> genderList = [ 'Male', 'Female', 'Prefer Not to Say']; // Ensure 'Not Set' is included

    final savedGender = _storage.read(genderKey);
    if (savedGender != null && genderList.contains(savedGender)) {
      gender.value = savedGender;
    }
    if (savedDate is String) {
      dateofBirth.value = DateTime.parse(savedDate);  // Correctly parse the date string
    } else if (savedDate is DateTime) {
      dateofBirth.value = savedDate;  // Already a DateTime object
    }
    return  Scaffold(
      appBar: const TAppbar(title: Text('Profile'),  showBackArrow: true ,),

      // Body-----
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Profile picture -----------
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                          final networkImage = controller.user.value.profilePicture;
                          final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                          return  controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80, radius: 80,)
                          : TCircularImage(image: image, height: 80, width: 80, isNetworkImage: networkImage.isNotEmpty,);}),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              //----------Details
              const SizedBox(height: 8,),
              const Divider(),
              const SizedBox(height: 16),

              // profile info
              const TSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: 16,),

              TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: (){}),
              TProfileMenu(title: 'UserName', value: controller.user.value.username, onPressed: () {  },),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height:16),

              // ----Heading personal info
              const TSectionHeading(title: 'Personal Information' , showActionButton: false,),
              const SizedBox(height: 16),

              TProfileMenu(title: 'UserId', value:  controller.user.value.id ,icon: Iconsax.copy, onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.user.value.id));
                showSnackBar(context, 'Copied to Clipboard');
                },),
              
              TProfileMenu(title: 'Email', value:  controller.user.value.email , onPressed: () {  },),
              TProfileMenu(title: 'PhoneNumber', value:  controller.user.value.phoneNumber , onPressed: () {  },),

              Obx(() => TProfileMenu(
                title: 'Gender',
                value: gender.value,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Gender'),
                        content: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          //style: AppStyles().subTitleStyle,
                          underline: Container(height: 0,),
                          items: genderList.map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value! ,style:  const TextStyle(color:Colors.grey )),
                            );
                          }).toList(),
                          onChanged: (String? newValue)  {
                            gender.value = newValue!;
                            _storage.write(genderKey, newValue);
                            Navigator.of(context).pop();
                          },
                        )
                      );
                    },
                  );
                },
              )),
              Obx(() => TProfileMenu(
                title: 'Date of Birth',
                value: dateofBirth.value != null
                    ? '${dateofBirth.value!.day}-${dateofBirth.value!.month}-${dateofBirth.value!.year}'
                    : 'Not Set',
                onPressed: () async {
                  DateTime? birthdate = await showDatePicker(
                    context: context,
                    initialDate: dateofBirth.value ?? DateTime.now(),
                    firstDate: DateTime(1920),
                    lastDate: DateTime.now(),
                  );
                  if (birthdate != null) {
                    _storage.write(_dateOfBirthKey, birthdate.toIso8601String());
                    dateofBirth.value = birthdate;  // Update the date immediately
                  }
                },
              )),

              const Divider(),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  child: const Text('Close Account' , style: TextStyle(color: Colors.red),),
                  onPressed: () => controller.deleteAccountWarningPopup(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


