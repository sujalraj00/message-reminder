import 'package:flutter/material.dart';
import 'package:message_reminder/controllers/remind_controller.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final remindController = Get.put(RemindController());
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
  @override
  Widget build(BuildContext context) {
    remindController.getReminders();

    return Scaffold(
      body: Obx(() {
        List<Reminders> reminders = fetchUpcomingReminders(remindController.remindList);
        List<Reminders> passedReminders = fetchPassedReminders(remindController.remindList);

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
                    return ReminderCard( color: _getBGClr(reminder?.color??0),
                        contactName: reminder.title ?? 'No Title',
                        time: reminder.startTime ?? '',
                        messagePreview: reminder.note ?? 'No Note');
                  },
                )
                    : const Center(
                  child: Card( shadowColor: Colors.grey, elevation: 0.2,
                    child: Text(
                      'No reminders set',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Recent Interactions
                const Text(
                  'Passed Interactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                passedReminders.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    Reminders reminder = reminders[index];
                    return ReminderCard( color: Colors.purple[100]!,
                        contactName: reminder.title ?? 'No Title',
                        time: reminder.startTime ?? '',
                        messagePreview: reminder.note ?? 'No Note');
                  },
                )
                    : const Center(
                  child: Card( shadowColor: Colors.grey, elevation: 0.2,
                    child: Text(
                      'Nothing Missed',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
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
        );
      }),
    );

  }

  DateTime parseReminderDateTime(String date, String startTime) {
    try {
      final dateParts = date.split('/');
      final timeParts = startTime.split(' ');
      final time = timeParts[0].split(':');
      final period = timeParts.length > 1 ? timeParts[1].toUpperCase() : '';

      int hour = int.parse(time[0]);
      final minute = int.parse(time[1]);

      if (period == 'PM' && hour < 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      DateTime parsedDateTime = DateTime(
        int.parse(dateParts[2]), // year
        int.parse(dateParts[0]), // day
        int.parse(dateParts[1]), // month
        hour,
        minute,
      );

      print('Parsed date and time for reminder: $date $startTime -> $parsedDateTime');
      return parsedDateTime;
    } catch (e) {
      print('Error parsing date and time: $date $startTime, Error: $e');
      return DateTime.now(); // Fallback to current time in case of error
    }
  }

  List<Reminders> fetchUpcomingReminders(List<Reminders> reminders) {
    DateTime now = DateTime.now();
    print('Current time: $now');

    List<Reminders> upcomingReminders = [];
    for (var reminder in reminders) {
      try {
        DateTime reminderDateTime = parseReminderDateTime(reminder.date!, reminder.startTime!);
        print('Checking reminder: ${reminder.title}, DateTime: $reminderDateTime, Now: $now');
        if (reminderDateTime.isAfter(now)) {
          upcomingReminders.add(reminder);
        } else {
          print('Reminder ${reminder.title} is in the past and will not be included.');
        }
      } catch (e) {
        print('Error parsing reminder: ${reminder.title}, Error: $e');
      }
    }

    // Sorting the filtered reminders
    upcomingReminders.sort((a, b) {
      DateTime dateTimeA = parseReminderDateTime(a.date!, a.startTime!);
      DateTime dateTimeB = parseReminderDateTime(b.date!, b.startTime!);
      return dateTimeA.compareTo(dateTimeB);
    });

    print('Upcoming Reminders: $upcomingReminders');
    return upcomingReminders.take(4).toList();
  }

  List<Reminders> fetchPassedReminders(List<Reminders> reminders) {
    DateTime now = DateTime.now();
    print('Current time: $now');

    List<Reminders> passedReminders = [];
    for (var reminder in reminders) {
      try {
        DateTime reminderDateTime = parseReminderDateTime(reminder.date!, reminder.startTime!);
        print('Checking reminder: ${reminder.title}, DateTime: $reminderDateTime, Now: $now');
        if (reminderDateTime.isBefore(now)) {
          passedReminders.add(reminder);
        } else {
          print('Reminder ${reminder.title} is in the future and will not be included.');
        }
      } catch (e) {
        print('Error parsing reminder: ${reminder.title}, Error: $e');
      }
    }

    // Sorting the filtered reminders
    passedReminders.sort((a, b) {
      DateTime dateTimeA = parseReminderDateTime(a.date!, a.startTime!);
      DateTime dateTimeB = parseReminderDateTime(b.date!, b.startTime!);
      return dateTimeA.compareTo(dateTimeB);
    });

    print('Upcoming Reminders: $passedReminders');
    return passedReminders.take(3).toList();
  }
}

class ReminderCard extends StatelessWidget {
  final String contactName;
  final String time;
  final String messagePreview;
  final Color color;

  const ReminderCard({super.key, required this.contactName, required this.time, required this.messagePreview, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Assuming color is set somewhere else
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
        child: ListTile(
          title: Text(contactName, style: const TextStyle(color: TColors.white)),
          subtitle: Text('$time\n$messagePreview', style: const TextStyle(color: TColors.white)),
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: Icon(Icons.send, color: TColors.white.withOpacity(0.9)),
                onPressed: () {
                  // Send message
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

  const MetricsCard({super.key, required this.weeklyInteractions, required this.missedReminders});

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
