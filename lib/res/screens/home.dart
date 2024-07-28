import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const Icon(Icons.person),
      //   title: const Text('ConnectRemind'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.settings),
      //       onPressed: () {
      //         // Navigate to settings screen
      //       },
      //     ),
      //   ],
      // ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upcoming Reminders
              Text(
                'Upcoming Reminders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ReminderCard(
                contactName: 'John Doe',
                time: 'Today, 3:00 PM',
                messagePreview: 'Hey, let’s catch up later...',
              ),
              ReminderCard(
                contactName: 'Jane Smith',
                time: 'Tomorrow, 9:00 AM',
                messagePreview: 'Don’t forget about our meeting...',
              ),
              SizedBox(height: 20),

              // Recent Interactions
              Text(
                'Recent Interactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              InteractionItem(
                contactName: 'Alice Johnson',
                lastMessage: 'Great talking to you!',
              ),
              InteractionItem(
                contactName: 'Bob Brown',
                lastMessage: 'See you soon!',
              ),
              SizedBox(height: 20),

              // Metrics Overview
              Text(
                'Metrics Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              MetricsCard(
                weeklyInteractions: 5,
                missedReminders: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReminderCard extends StatelessWidget {
  final String contactName;
  final String time;
  final String messagePreview;

  const ReminderCard({super.key, required this.contactName,required this.time,required this.messagePreview, });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(contactName),
        subtitle: Text('$time\n$messagePreview'),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // Send message
              },
            ),
            IconButton(
              icon: const Icon(Icons.snooze),
              onPressed: () {
                // Snooze reminder
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Edit reminder
              },
            ),
          ],
        ),
      ),
    );
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
