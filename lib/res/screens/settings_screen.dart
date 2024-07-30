import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/profile_screen.dart';
import 'package:message_reminder/widgets/primary_header_container.dart';
import 'package:message_reminder/widgets/section_heading.dart';
import 'package:message_reminder/widgets/settings_menu_tile.dart';
import 'package:message_reminder/widgets/t_appbar.dart';
import 'package:message_reminder/widgets/user_profile_tile.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -------header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    // Appbar
                    // TAppbar(
                    //   title: Text(
                    //     'Account',
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .headlineMedium!
                    //         .apply(color: TColors.white),
                    //   ),
                    // ),

                    // User Profile Card
                    TUserProfileTile(
                        onPressed: () => Get.to(() => Padding(
                          padding: const EdgeInsets.all(20),
                          child: const ProfileScreen(),
                        ))),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                )),

            // -----------body
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Account Setting--
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),


                  const TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected account',
                  ),

                  // --------- App Setting
                  const SizedBox(
                    height: 32,
                  ),
                  const TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'load Data',
                    subtitle: 'Upload data to your cloud firebase',
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subtitle: 'Set recommendation based on location',
                      trailing: Switch(value: true, onChanged: (value) {})),
                  TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Safe Mode',
                      subtitle: 'Search result is safe for all ages',
                      trailing: Switch(value: false, onChanged: (value) {})),
                  TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'HD Image Quality',
                      subtitle: 'Set Image quality to be seen',
                      trailing: Switch(value: false, onChanged: (value) {})),

                  // --------- LogOut button
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => controller.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: 32 * 2.5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
