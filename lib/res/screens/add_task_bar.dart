import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:message_reminder/controllers/remind_controller.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:message_reminder/res/consts/input_field_reminder.dart';
import 'package:message_reminder/res/consts/styles.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/reminders_screen.dart';

import '../../widgets/button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final RemindController _remindController = Get.put(RemindController());
 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5, 10, 15, 20
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None", "Daily", "Weekly", "Monthly"
  ];

  int _selectedColor =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Reminders',
                style: AppStyles().headingStyle,
              ),
              MyInputReminder(title: 'Title', hint: 'Enter Your Title', controller: _titleController),
              MyInputReminder(title: 'Note', hint: 'Enter Your Note', controller: _noteController,),
              MyInputReminder(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getDateFromUser();
                    }),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputReminder(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                        ),
                      )),
                  const SizedBox(
                    width: 11,
                  ),
                  Expanded(
                      child: MyInputReminder(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                        ),
                      ))
                ],
              ),
              MyInputReminder(title: 'Remind',
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: AppStyles().subTitleStyle,
                  underline: Container(height: 0,),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (String? newValue)  {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  )
                ,),
              MyInputReminder(title: 'Repeat',
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: AppStyles().subTitleStyle,
                  underline: Container(height: 0,),
                  items: repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value! ,style:  const TextStyle(color:Colors.grey )),
                    );
                  }).toList(),
                  onChanged: (String? newValue)  {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                )
                ,),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Reminder", onTap: ()=>
                    _validateDate()
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();

    } else if(_titleController.text.isEmpty || _noteController.text.isEmpty ){

      Get.snackbar("Required", "All fields are required !",
      snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.pink,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red,)
      );
    }
  }

 _addTaskToDb() async{
 int value= await _remindController.addReminder(
    reminders : Reminders(
      note : _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0
    )
  );
 print("My id is "+"$value");
 }

  _colorPallete(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: AppStyles().titleStyle,),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index ==0 ? TColors.primary : index ==1 ? Colors.pink : Colors.yellow,
                    child: _selectedColor ==index?
                    Icon(Icons.done,color: Colors.white, size: 16,)
                        : Container()
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2050));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print('its null or something is wrong');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('time canceled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == true) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]))
    );
  }
}
