import 'package:flutter/material.dart';
import 'package:message_reminder/controllers/remind_controller.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/home_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});  final remindController = Get.put(RemindController());
 // final RemindController remindController = Get.find<RemindController>();
  //final List<Reminders> reminders;
  @override
  Widget build(BuildContext context) {

    remindController.getReminders();
//List<Reminders> upcomingReminders = fetchUpcomingReminders(reminders);
    return  Scaffold(
            body: Obx((){   List<Reminders> reminders = remindController.remindList;
              return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                              // Upcoming Reminders
                const Text(
                  'Upcoming Reminders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                    reminders.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    Reminders reminder = reminders[index];
                    // return ListTile(
                    //   title: Text(reminder.title ?? 'No Title'),
                    //   subtitle: Text(reminder.note ?? 'No Note'),
                    //   trailing: Text(
                    //     '${reminder.startTime}',
                    //   ),
                    // );
                   return ReminderCard(contactName: Text(reminder.title!).toString(), time:'${reminder.startTime}'.toString() , messagePreview: reminder.note.toString()); },
                )
                    : const Center(
                  child: Text(
                    'No reminders set',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              

                const SizedBox(height: 20),
              
                // Recent Interactions
                const Text(
                  'Recent Interactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const InteractionItem(
                  contactName: 'Alice Johnson',
                  lastMessage: 'Great talking to you!',
                ),
                const InteractionItem(
                  contactName: 'Bob Brown',
                  lastMessage: 'See you soon!',
                ),
                const SizedBox(height: 20),
              
                // Metrics Overview
                const Text(
                  'Metrics Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const MetricsCard(
                  weeklyInteractions: 5,
                  missedReminders: 1,
                ),
              ],
                        ),
                      ),
                    );}
            ),
    );

  }

  DateTime parseReminderDateTime(String date, String startTime) {
    final dateParts = date.split('/');
    final timeParts = startTime.split(':');
    return DateTime(
      int.parse(dateParts[2]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[0]), // day
      int.parse(timeParts[0]), // hour
      int.parse(timeParts[1]), // minute
    );
  }

  List<Reminders> fetchUpcomingReminders(List<Reminders> reminders) {
    reminders.sort((a, b) {
      DateTime dateTimeA = parseReminderDateTime(a.date!, a.startTime!);
      DateTime dateTimeB = parseReminderDateTime(b.date!, b.startTime!);
      return dateTimeA.compareTo(dateTimeB);
    });

    return reminders.take(3).toList();
  }

}

class ReminderCard extends StatelessWidget {
  final String contactName;
  final String time;
  final String messagePreview;


  const ReminderCard({super.key, required this.contactName,required this.time,required this.messagePreview, this.reminders });
  final Reminders? reminders;
  @override
  Widget build(BuildContext context) {
       return Card(
      color:  _getBGClr(reminders?.color??0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical:  10),
        child: ListTile(
          title: Text(reminders?.title??"", style: const TextStyle(color: TColors.white),),
          subtitle: Text('$time\n$reminders?.note??""', style: const TextStyle(color: TColors.white)),
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon:  Icon(Icons.send, color: TColors.white.withOpacity(0.9),),
                onPressed: () {
                  // Send message
                },
              ),
              IconButton(
                icon:  Icon(Icons.snooze,  color: TColors.white.withOpacity(0.9)),
                onPressed: () {
                  // Snooze reminder
                },
              ),
              IconButton(
                icon: Icon(Icons.edit,  color: TColors.white.withOpacity(0.9)),
                onPressed: () {
                  // Edit reminder
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return TColors.primary;
      case 1:
        return Colors.pink;
      case 2:
        return Colors.orange;
      default:
        return TColors.primary;
    }
  }
}

class InteractionItem extends StatelessWidget {
  final String contactName;
  final String lastMessage;

  const InteractionItem({super.key, required this.contactName, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contactName),
      subtitle: Text(lastMessage),
    );
  }
}

class MetricsCard extends StatelessWidget {
  final int weeklyInteractions;
  final int missedReminders;

  const MetricsCard({super.key, required this.weeklyInteractions,required this.missedReminders});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly Interactions: $weeklyInteractions'),
            const SizedBox(height: 10),
            Text('Missed Reminders: $missedReminders'),
          ],
        ),
      ),
    );
  }



}
