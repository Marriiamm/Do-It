import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controllers.dart';
import 'package:todo/models/task_model.dart';

import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15))).toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedrepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              TextFieldd(
                label: 'title',
                hint: 'enter title here',
                controller: titleController,
              ),
              TextFieldd(
                label: 'Note',
                hint: 'enter Note here',
                controller: noteController,
              ),
              TextFieldd(
                label: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                    onPressed: () => getDateFromUser(),
                    icon:  Icon(
                      Icons.calendar_today_rounded,
                      color: Get.isDarkMode?kdarkDo3: kDarkGreen,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFieldd(
                      label: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: true),
                          icon: Icon(
                            Icons.schedule_rounded,
                            color: Get.isDarkMode?kdarkDo3: kDarkGreen,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: TextFieldd(
                      label: 'End Time',
                      hint: endTime,
                      widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: false),
                          icon: Icon(
                            Icons.schedule_rounded,
                            color: Get.isDarkMode?kdarkDo3: kDarkGreen,
                          )),
                    ),
                  ),
                ],
              ),
              TextFieldd(
                label: 'Remind',
                hint: '$selectedRemind minutes early',
                widget: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: Get.isDarkMode?kdarkDo3: kLightGreen ,
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    '$value',
                                    style: TextStyle(color: Get.isDarkMode?Colors.white: kdarkClr),
                                  )))
                          .toList(),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Get.isDarkMode?kdarkDo3: kDarkGreen,
                        size: 40,
                      ),
                      elevation: 4,
                      underline: Container(height: 0),
                      style: supTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRemind = int.parse(newValue!);
                        });
                      }),
                ),
              ),
              TextFieldd(
                label: 'Repeat',
                hint: selectedrepeat,
                widget: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DropdownButton(
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: Get.isDarkMode?kdarkDo3: kDarkGreen,
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: kdarkClr),
                                  )))
                          .toList(),
                      icon:  Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Get.isDarkMode?kdarkDo3: kDarkGreen,
                        size: 40,
                      ),
                      elevation: 4,
                      underline: Container(height: 0),
                      style: supTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedrepeat = newValue!;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    colorWidget(),
                    UiButton(
                      label: 'Create Task',
                      onTap: () {
                        validateDate();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column colorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        Wrap(
            children: List<Widget>.generate(
          3,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: index == 0
                    ? Get.isDarkMode?kdarkDo1: kDarkGreen
                    : index == 1
                        ? Get.isDarkMode? kdarkDo2: kLightBeige
                        : Get.isDarkMode? kdarkDo3: kLightGreen,
                child: selectedColor == index ? const Icon(Icons.done,color: Colors.white,) : null,
              ),
            ),
          ),
        ))
      ],
    );
  }

  validateDate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTasksToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
        shouldIconPulse: true,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        titleText: const Text(
          'Error',
          style: TextStyle(fontFamily: 'Exo2', color: Colors.white),
        ),
        messageText: const Text(
          'All Fields are required',
          style: TextStyle(fontFamily: 'Exo2', color: Colors.white),
        ),
      );
    } else {
      print('An error occured');
    }
  }

  addTasksToDb() async {
    int value = await taskController.addTask(
        task: TaskModel(
      title: titleController.text,
      note: noteController.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      color: selectedColor,
      remind: selectedRemind,
      repeat: selectedrepeat,
    ));
    print('$value');
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      actions: const [
        CircleAvatar(
          radius: 19,
          backgroundImage: AssetImage(
            "assets/images/businessman.png",
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  getDateFromUser() async {
    // ignore: non_constant_identifier_names
    DateTime? PickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (PickedDate != null) {
      setState(() {
        selectedDate = PickedDate;
      });
    } else {
      print('');
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    // ignore: non_constant_identifier_names
    TimeOfDay? PickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    // ignore: use_build_context_synchronously
    String formattedTime = PickedTime!.format(context);
    if (isStartTime) {
      setState(() {
        startTime = formattedTime;
      });
    } else if (!isStartTime) {
      setState(() {
        endTime = formattedTime;
      });
    } else {
      print('Time Canceled');
    }
  }
}
