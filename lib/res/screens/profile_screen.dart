import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/user_controller.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/widgets/circular_image.dart';
import 'package:message_reminder/widgets/profile_menu.dart';
import 'package:message_reminder/widgets/section_heading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return  Scaffold(
    //  appBar: const TAppbar(title: Text('Profile'),  showBackArrow: true ,),

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
                    const TCircularImage(image: TImages.user, height: 80, width: 80,),
                    TextButton(onPressed: () {}, child: const Text('Change Profile Picture')),
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

              TProfileMenu(title: 'UserId', value:  controller.user.value.id ,icon: Iconsax.copy, onPressed: () {  },),
              TProfileMenu(title: 'Email', value:  controller.user.value.email , onPressed: () {  },),
              TProfileMenu(title: 'PhoneNumber', value:  controller.user.value.phoneNumber , onPressed: () {  },),
              TProfileMenu(title: 'Gender', value:  'Male' , onPressed: () {  },),
              TProfileMenu(title: 'Date of Birth', value: '23-05-2024', onPressed: () {  },),

              const Divider(),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  child: const Text('Close Account' , style: TextStyle(color: Colors.red),),
                  onPressed: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


