import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/task_controllers.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/size_config.dart';
import 'package:todo/theme.dart';
import '../widgets/button.dart';
import 'package:intl/intl.dart';
import 'addtask.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskController taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: customAppBar(),
        body: Column(
          children: [
            addTaskBar(),
            addDateBar(),
            const SizedBox(
              height: 10,
            ),
            //showTasks(),
          ],
        ));
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_rounded,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () => ThemeServices().switchTheme(),
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

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: supHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
          UiButton(
            label: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskView());
              taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  addDateBar() {
    var textStyle = TextStyle(
          fontFamily: "Exo2",
          color: Get.isDarkMode ? Colors.white : Colors.black,
        );
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate:DateTime.now() ,
        dayTextStyle: textStyle,
        monthTextStyle: textStyle,
        dateTextStyle: textStyle,
        onDateChange: (newDate) {
          selectedDate = newDate;
        },
        selectedTextColor: Get.isDarkMode ? Colors.white : Colors.black,
        selectionColor: Get.isDarkMode ? kdarkDod : kgray,
      ),
    );
  }

  showTasks() {}
}
