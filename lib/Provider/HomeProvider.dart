import 'package:flutter/material.dart';
import 'package:todo_list/model/Task.dart';
import 'package:todo_list/util/DatabaseHelper.dart';

class HomeProvider extends ChangeNotifier{
   List<Task>?allTask;
   HomeProvider(){
     getTasks();
   }
  getTasks() async {
    List<Map<String, Object?>> tasks= await DbHelper.dbHelper.getAllTask();
    allTask = tasks.map((e) {
      return Task.fromJson(e);
    }).toList();
    notifyListeners();
  }
}