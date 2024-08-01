import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/add_new_address.dart';
import 'package:message_reminder/res/screens/single_address.dart';
import 'package:message_reminder/widgets/t_appbar.dart';



class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()=> Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Icons.add ,color: TColors.white,),),
      appBar: TAppbar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),

      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TSingleAddress(selectedAddress: true),
            TSingleAddress(selectedAddress: false ),
          ],
        ),
      ),
    );
  }
}
