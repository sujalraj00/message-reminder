import 'package:get/get.dart';
import 'package:message_reminder/db/db_helper.dart';

import '../models/reminders.dart';

class RemindController extends GetxController{


  @override
  void onReady() {
    super.onReady();
  }

  var remindList =  <Reminders>[].obs;

  Future<int> addReminder({Reminders? reminders}) async{
    return await DBHelper.insert(reminders);
  }

  // get all the data from table
  void getReminders() async{
    List<Map<String,dynamic>> reminder = await DBHelper.query();
    remindList.assignAll(reminder.map((data) => new Reminders.fromJson(data)).toList());
  }

  void delete(Reminders reminders){
    DBHelper.delete(reminders);
    getReminders();
  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getReminders();
  }
}