import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/privacy_policy_webview.dart';
import 'package:message_reminder/Authentication/webView.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/profile_screen.dart';
import 'package:message_reminder/res/screens/user_address_screen.dart';
import 'package:message_reminder/services/notification_services.dart';
import 'package:message_reminder/services/theme_services.dart';
import 'package:message_reminder/widgets/primary_header_container.dart';
import 'package:message_reminder/widgets/section_heading.dart';
import 'package:message_reminder/widgets/settings_menu_tile.dart';
import 'package:message_reminder/widgets/user_profile_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key})  {
    _notifyHelper = NotifyHelper();
    _notifyHelper.initializeNotification();
    _notifyHelper.requestIOSPermissions();
  }
  late final NotifyHelper _notifyHelper;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
   // final controllerWeb = Get.put(WebViewEx());
    final controllerWeb = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://flutter.dev'));

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
                    Padding(
                      padding: const EdgeInsets.only(top:  75, bottom: 10),
                      child: TUserProfileTile(
                          onPressed: () => Get.to(() => const ProfileScreen())),
                    ),
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
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                   TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Privacy Policy',
                    subtitle: 'App\'s privacy policy',
                    onTap: () => Get.to(() => PrivacyPolicyWebView())
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

                  TSettingsMenuTile(
                      icon: Icons.nightlight_round,  title: "Theme", subtitle: "change theme here",
                    onTap: (){
    ThemeService().switchTheme();
    _notifyHelper.displayNotification(
    title:"Theme Changed",
    body: Get.isDarkMode ? "Activated Light Theme" : "Activated Dark Theme "
    );}
                  ),

                  const TSettingsMenuTile(icon: Icons.help, title: "Contact Us", subtitle: "at nurdatabase2@gmail.com"),


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
