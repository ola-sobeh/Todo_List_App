import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Provider/AddTaskProvider.dart';
import 'package:todo_list/model/Task.dart';
import 'package:todo_list/ui/Pages/AddTaskPage.dart';

class TaskWidget extends StatelessWidget {
  late Task task;
  TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
        builder: (context, provider, x) {
          return GestureDetector(
            onTap:()=>{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddTaskPage(task: task,)))
            },
            child: Container(
                child:Row(
                  children: [

                    Text(
                        this.task.title,
                      style: TextStyle(fontSize: 15),
                    ),
                  Spacer(),
                  Checkbox(
                      activeColor:Colors.indigo ,
                      value: task.status == 1 ? true : false,
                      onChanged: (v) {
                        task.status = v==true ? 1 : 0;
                        provider.updateTaskStauts(task);
                      })
                  ],
                )
            ),
          );
        });
  }

}
