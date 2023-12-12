import 'package:get/get.dart';
import '../models/task_model.dart';

class TaskController extends GetxController{
  final taskList =<TaskModel>[
    TaskModel(
       id: 4,
      title: "to finish todo",
      note: "i can do it inshaalah",
      isCompleted: 0,
      startTime: "3:45",
      endTime: "4:00",
      color: 1,

    ),
    TaskModel(
       id: 0,
      title: "to finish todo",
      note: "i can do it inshaalah",
      isCompleted: 1,
      startTime: "3:45",
      endTime: "4:00",
      color: 0,

    ),
    TaskModel(
       id: 1,
      title: "to finish todo",
      note: "i can do it inshaalah",
      isCompleted: 0,
      startTime: "3:45",
      endTime: "4:00",
      color: 2,

    ),
    TaskModel(
      id: 2,
      title: "to finish todo",
      note: "i can do it inshaalah",
      isCompleted: 0,
      startTime: "3:45",
      endTime: "4:00",
      color: 1,

    ),
    TaskModel(
       id: 3,
      title: "to finish todo",
      note: "i can do it inshaalah",
      isCompleted: 0,
      startTime: "3:45",
      endTime: "4:00",
      color: 0,

    ),
  ];
  getTasks(){}
}