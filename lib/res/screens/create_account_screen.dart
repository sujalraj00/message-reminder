import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/res/consts/validator.dart';
import 'package:message_reminder/res/helper/helper_function.dart';
import 'package:message_reminder/res/screens/navigation_menu.dart';
import 'package:message_reminder/widgets/form_divider.dart';
import 'package:message_reminder/widgets/social_buttons.dart';

import '../../controllers/sign_up_controller.dart';
import '../../widgets/terms_and_condition_checkbox.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text('Let\'s Create Your Account', style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: 32,),

              // form
              Form(
                key: controller.signupFormKey,
                  child:  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:controller.firstName ,
                              validator:(value) => TValidator.validateEmptyText('First Name', value) ,
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                          const SizedBox(
                              width: 16 ),
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastName,
                              validator: (value) =>
                                  TValidator.validateEmptyText('Last name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: "Last Name",
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      // username
                      TextFormField(
                        controller: controller.username,
                        validator: (value) =>
                            TValidator.validateEmptyText('Username', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Iconsax.user_edit)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // email
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: 'E-mail', prefixIcon: Icon(Iconsax.direct)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // password
                      Obx(
                            () => TextFormField(
                          controller: controller.password,
                          validator: (value) => TValidator.validatePassword(value),
                          obscureText: controller.hidePassword.value ,
                          decoration:  InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value ,
                                icon:  Icon( controller.hidePassword.value ?  Iconsax.eye_slash : Iconsax.eye)),
                          ),),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // terms and condition
                      const TermsAndConditionCheckBox(),
                      const SizedBox(
                        height: 32,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // onPressed: () => controller.signup(),
                          onPressed: () => controller.signup(),
                          child: const Text('Create Account'),
                        ),
                      )
                    ],
                  )),

              const SizedBox(height: 32),
              const FormDivider(),
              const SizedBox(height: 32),
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
