import 'package:flutter/material.dart';
import 'package:todo_list/model/Task.dart';
import 'package:todo_list/util/DatabaseHelper.dart';

class AddTaskProvider extends ChangeNotifier {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDetailsController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  GlobalKey<FormState> addNewKey = GlobalKey<FormState>();
  List<Task> allTask = <Task>[];
  List<Task> allCompletedTask = <Task>[];
  late int? totalTaskNum;
  late int totalCompleteTask ;

  AddTaskProvider() {
    getTasks();
  }

  createTask() {
    if (addNewKey.currentState!.validate()) {
      Task task = Task(
          title: taskTitleController.text,
          //date: taskDateController.value as DateTime ,
          Details: taskDetailsController.text);
      insetTaskToDB(task);
    }
  }

  insetTaskToDB(Task task) async {
    await DbHelper.dbHelper.insertTask(task);
    getTasks();
    notifyListeners();
  }

 updateTask(Task task) async {
    if (addNewKey.currentState!.validate()) {
          task.title= taskTitleController.text;
          task.Details= taskDetailsController.text;
          await DbHelper.dbHelper.updateTask(task);
          getTasks();
          notifyListeners();
    }

  }
  updateTaskStauts(Task task)async{
    await DbHelper.dbHelper.updateTask(task);
    getTasks();
    notifyListeners();
  }
  getTasks() async {
    List<Map<String, Object?>> tasks = await DbHelper.dbHelper.getAllTask();
    allTask = tasks.map((e) {
      return Task.fromJson(e);
    }).toList();
    this.allCompletedTask =
        this.allTask.where((element) => element.status==1).toList();
    totalTaskNum = allTask.length;
    totalCompleteTask =allCompletedTask.length;
    notifyListeners();
  }

  deleteTask(Task task) async {
    await DbHelper.dbHelper.deleteTask(task.id!);
    allTask.remove(task);
    getTasks();
    notifyListeners();
  }

   getProgressPercentage() {
    double percentage =
        (totalCompleteTask / totalTaskNum!) *100;
    print(totalCompleteTask);
    print(totalTaskNum);

    return percentage;
  }
}
