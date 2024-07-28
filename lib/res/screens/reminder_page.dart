import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:message_reminder/res/consts/styles.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/consts/theme/theme.dart';
import 'package:message_reminder/res/helper/helper_function.dart';
import 'package:message_reminder/res/screens/add_task_bar.dart';
import 'package:message_reminder/widgets/button.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../../controllers/remind_controller.dart';
import '../../services/notification_services.dart';
import '../../widgets/task_tile.dart';


class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
DateTime _selectedDate = DateTime.now() ;
final _remindController = Get.put(RemindController());
var notifyHelper;
@override
void initState() {
  super.initState();
  notifyHelper = NotifyHelper();
  notifyHelper.initializeNotification();
  notifyHelper.requestIOSPermissions();

}


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
         _addTaskBar(),
         _addDateBar(),
         const SizedBox(height: 12,),
         _showTask()
            ],
          )

    );


  }

  _addDateBar(){
   return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: TColors.primary,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),),
        dayTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),),
        monthTextStyle: GoogleFonts.lato(textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),),
        onDateChange: (date){
         setState(() {
           _selectedDate = date;
         });
        },
      ),
    );
  }

  _addTaskBar(){
   return Container(
      margin: const EdgeInsets.only(left: 20, right: 20 , top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()), style: AppStyles().subHeadingStyle),
                  Text('Today', style: AppStyles().headingStyle,)
                ],
              ),
            ),
            MyButton(label: "+Add Reminder", onTap: () async{
              await Get.to(() =>const AddTaskPage());
              _remindController.getReminders();
            })
          ]
      ),
    );
  }



_showTask() {
  return Expanded(
      child: Obx(() {
      //  _remindController.getReminders();
        return ListView.builder(
            itemCount: _remindController.remindList.length,
            itemBuilder: (_, index) {
              Reminders reminders = _remindController.remindList[index];
              print(reminders.toJson());

              DateTime date = DateFormat("hh:mm a").parse(reminders.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              print(myTime);
              var title = reminders.title;
              var body = reminders.note;

              bool shouldShowReminder = false;

              switch (reminders.repeat) {
                case 'Daily':
                  notifyHelper.scheduledNotificationDaily(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      reminders,
                      title,
                      body
                  );
                  shouldShowReminder = true;
                  break;

                case 'Weekly':
                  DateTime reminderDate = DateFormat("M/d/yyyy").parse(reminders.date!);
                  if (_selectedDate.weekday == reminderDate.weekday) {
                    notifyHelper.scheduledNotificationWeekly(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        reminders,
                        title,
                        body
                    );
                    shouldShowReminder = true;
                  }
                  break;

                case 'Monthly':
                  DateTime reminderDate = DateFormat("M/d/yyyy").parse(reminders.date!);
                  if (_selectedDate.day == reminderDate.day) {
                    notifyHelper.scheduledNotificationMonthly(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        reminders,
                        title,
                        body
                    );
                    shouldShowReminder = true;
                  }
                  break;

                case 'None':
                  notifyHelper.scheduledNotificationNone(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      reminders,
                      title,
                      body
                  );
                  shouldShowReminder = reminders.date == DateFormat.yMd().format(_selectedDate);
                  break;

                default:
                  shouldShowReminder = reminders.date == DateFormat.yMd().format(_selectedDate);
              }

              if (shouldShowReminder) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, reminders);
                              },
                              child: TaskTile(reminders),
                            )
                          ],
                        ),
                      ),
                    )
                );
              } else {
                return Container();
              }
            }
        );
      })
  );
}
_showBottomSheet(BuildContext context, Reminders reminders) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        height: reminders.isCompleted==1?
        MediaQuery.of(context).size.height * 0.24 :
        MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? TColors.darkerGrey: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]
              ),
            ),
            Spacer(),
            reminders.isCompleted ==1 ?
                Container()
                : _bottomSheetButton(
                label: "Task Completed",
                onTap: (){
                  _remindController.markTaskCompleted(reminders.id!);
                  Get.back();
                },
                clr: TColors.primary, context: context),

            _bottomSheetButton(
                label: "Delete Task",
                onTap: () async{
                  _remindController.delete(reminders);
                  await notifyHelper.cancelScheduledNotification(reminders.id!.toInt());
                   Get.back();
                },
                clr: Colors.red[300]!,
                context: context),
            SizedBox(height: 20,),
            _bottomSheetButton(
                label: "Close",
                onTap: (){
                  Get.back();
                },
                clr: Colors.red[300]!,
                isClose: true,
                context: context),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
}

 _bottomSheetButton({
  required String label, required Function()? onTap, required Color clr, bool isClose = false, required BuildContext context
 }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration:  BoxDecoration(
          border:  Border.all(
            width: 2,
            color:isClose == true ? Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]! : clr,
          ),
            color: isClose == true ? Colors.transparent : clr,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text(
            label, style: isClose ? AppStyles().titleStyle : AppStyles().titleStyle .copyWith(color: Colors.white)
          ),
        )
      ),
    );
 }

}
