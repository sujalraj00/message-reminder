// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:message_reminder/services/notification_services.dart';
//
// class Reminder {
//   final String contactName;
//   final String message;
//   final String frequency;
//   final TimeOfDay time;
//   final DateTime createdAt;
//
//   Reminder({
//     required this.contactName,
//     required this.message,
//     required this.frequency,
//     required this.time,
//     required this.createdAt,
//   });
//
//   DateTime getNextOccurrence() {
//     DateTime now = DateTime.now();
//     DateTime reminderDateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     if (reminderDateTime.isBefore(now)) {
//       reminderDateTime = reminderDateTime.add(Duration(days: 1));
//     }
//
//     switch (frequency) {
//       case 'Daily':
//         return reminderDateTime;
//       case 'Weekly':
//         while (reminderDateTime.weekday != now.weekday) {
//           reminderDateTime = reminderDateTime.add(Duration(days: 1));
//         }
//         return reminderDateTime;
//       case 'Monthly':
//         return DateTime(now.year, now.month + 1, now.day, time.hour, time.minute);
//       default:
//         return reminderDateTime;
//     }
//   }
// }
//
// class ReminderScreen extends StatefulWidget {
//   @override
//   _ReminderScreenState createState() => _ReminderScreenState();
// }
//
// class _ReminderScreenState extends State<ReminderScreen> {
//   List<Reminder> reminders = [];
//
//   var notifyHelper;
//   @override
//   void initState() {
//     super.initState();
//     notifyHelper = NotifyHelper();
//     notifyHelper.requestIOSPermissions();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Sort reminders based on their next occurrence
//     reminders.sort((a, b) => a.getNextOccurrence().compareTo(b.getNextOccurrence()));
//
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: reminders.length,
//         itemBuilder: (context, index) {
//           final reminder = reminders[index];
//           final nextOccurrence = reminder.getNextOccurrence();
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text(reminder.contactName),
//               subtitle: Text(reminder.message),
//               trailing: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text('${reminder.time.format(context)}'),
//                   Text(DateFormat('MMM d, y').format(nextOccurrence)),
//                   Text(reminder.frequency),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddReminderDialog(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showAddReminderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AddReminderDialog(
//           onReminderAdded: (reminder) {
//             setState(() {
//               reminders.add(reminder);
//               // Sorting is now done in the build method
//             });
//           },
//         );
//       },
//     );
//   }
// }
// class AddReminderDialog extends StatefulWidget {
//   final Function(Reminder) onReminderAdded;
//
//   AddReminderDialog({required this.onReminderAdded});
//
//   @override
//   _AddReminderDialogState createState() => _AddReminderDialogState();
// }
//
// class _AddReminderDialogState extends State<AddReminderDialog> {
//   final _formKey = GlobalKey<FormState>();
//   String _contactName = '';
//   String _message = '';
//   String _frequency = 'Daily';
//   TimeOfDay _selectedTime = TimeOfDay.now();
//
//   List<String> _frequencies = ['Daily', 'Weekly', 'Monthly'];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Reminder'),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Contact Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a contact name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _contactName = value!;
//                 },
//               ),
//               SizedBox(height: 10,),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Message'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a message';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _message = value!;
//                 },
//               ),
//               SizedBox(height: 10,),
//               DropdownButtonFormField(
//                 value: _frequency,
//                 items: _frequencies.map((String frequency) {
//                   return DropdownMenuItem(
//                     value: frequency,
//                     child: Text(frequency),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _frequency = newValue!;
//                   });
//                 },
//                 decoration: InputDecoration(labelText: 'Frequency'),
//               ),
//               SizedBox(height: 10,),
//               ListTile(
//                 title: Text('Time'),
//                 subtitle: Text(_selectedTime.format(context)),
//                 trailing: Icon(Icons.access_time),
//                 onTap: _selectTime,
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         ElevatedButton(
//           child: Text('Add'),
//           onPressed: _submitForm,
//         ),
//       ],
//     );
//   }
//
//   void _selectTime() async {
//     final TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (timeOfDay != null) {
//       setState(() {
//         _selectedTime = timeOfDay;
//       });
//     }
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       widget.onReminderAdded(Reminder(
//         contactName: _contactName,
//         message: _message,
//         frequency: _frequency,
//         time: _selectedTime,
//         createdAt: DateTime.now(),
//       ));
//       Navigator.of(context).pop();
//     }
//   }
// }
//
// // ... (AddReminderDialog implementation remains the same)