import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/task_controllers.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/size_config.dart';
import 'package:todo/theme.dart';
import '../services/notification_services.dart';
import '../widgets/button.dart';
import 'package:intl/intl.dart';
import '../widgets/tasktile.dart';
import 'addtask.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermission();
    taskController.getTasks();
  }

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
            showTasks(),
          ],
        ));
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.cleaning_services_rounded,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed:()=> taskController.deleteAllTasks(),
          ),
      actions:  [
        IconButton(
          icon: Icon(
            Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_rounded,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            ThemeServices().switchTheme();
          }),
        const CircleAvatar(
          radius: 19,
          backgroundImage: AssetImage(
            "assets/images/businessman.png",
          ),
        ),
        const SizedBox(
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
        initialSelectedDate: DateTime.now(),
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

  showTasks() {
    return Expanded(
      child: Obx(() {
        {
          if (taskController.taskList.isEmpty) {
            return onTaskMsg();
          } else {
            return ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemCount: taskController.taskList.length,
                itemBuilder: (context, index) {
                  var task = taskController.taskList[index];
                  if (task.repeat == 'Daily' ||
                      task.date == DateFormat.yMd().format(selectedDate) ||
                      (task.repeat == 'Weekly' &&
                          selectedDate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == 'Monthly' &&
                          DateFormat.yMd().parse(task.date!).day ==
                              selectedDate.day)) {
                    var date = DateFormat.jm().parse(task.startTime!);
                    var myTime = DateFormat('HH:mm').format(date);

                    notifyHelper.scheduledNotification(
                        int.parse(myTime.toString().split(':')[0]),
                        int.parse(myTime.toString().split(':')[1]),
                        task);
                    return AnimationConfiguration.staggeredList(
                      duration: const Duration(milliseconds: 1375),
                      position: index,
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                context,
                                task,
                              );
                            },
                            child: TaskTile(task),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 0,
                    );
                  }
                });
          }
        }
      }),
    );
  }

  onTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 900),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox(
                        height: 200,
                      ),
                Image.asset(
                  "assets/images/tasks.png",
                  height: 140,
                  semanticLabel: 'Task',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20),
                  child: Text(
                    "you do not have any task yet! \n add new tasks to make the most of your days",
                    style: supTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.9)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39),
          child: Column(
            children: [
              Flexible(
                  child: Container(
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: "Task Completed",
                      onTap: () {
                        notifyHelper.cancelNotification(task);
                        taskController.markAsCompletedTasks(task.id!);
                        Get.back();
                      },
                      clr: Get.isDarkMode ? kdarkDo3 : kDarkGreen),
              _buildBottomSheet(
                  label: "Cancel",
                  onTap: () {
                    Get.back();
                  },
                  clr: Get.isDarkMode ? kdarkDo2 : const Color(0xffA4DFE4)),
              const Divider(
                color: Colors.black26,
                indent: 70,
                endIndent: 70,
              ),
              _buildBottomSheet(
                  label: "Delete",
                  onTap: () {
                    notifyHelper.cancelNotification(task);
                    taskController.deleteTasks(task);
                    Get.back();
                  },
                  clr: const Color.fromARGB(240, 255, 82, 82)),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
