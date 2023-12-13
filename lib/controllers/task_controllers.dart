import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import '../models/task_model.dart';

class TaskController extends GetxController{
  final RxList<TaskModel> taskList =<TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}){
    return DbHelper.insertFun(task);
  }

  Future<void> getTasks()async{
    final List<Map<String,dynamic>> tasks =await DbHelper.queryy();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
  }

  void deleteTasks(TaskModel task)async{
    await DbHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks()async{
    await DbHelper.deleteAll();
    getTasks();
  }

  void markAsCompletedTasks(int id)async{
    await DbHelper.updateFun(id);
    getTasks();
  }
}