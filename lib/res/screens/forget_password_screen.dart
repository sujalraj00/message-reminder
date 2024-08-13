import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/forget_password_controller.dart';
import 'package:message_reminder/res/consts/validator.dart';
import 'package:message_reminder/widgets/t_appbar.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: const TAppbar(),
      body:  Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text("Forget password", style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: 16),
            Text("Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.",
              style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: 64) ,

            // text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration:const InputDecoration(
                  labelText: "E-Mail", prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // button
            SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: () =>controller.sendPasswordResetEmail(), child:const Text("Submit")))
          ],
        ),
      ),
    );
  }
}
