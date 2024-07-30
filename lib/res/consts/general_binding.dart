
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(NetworkManager());
  }

}