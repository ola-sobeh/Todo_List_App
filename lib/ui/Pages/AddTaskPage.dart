import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Provider/AddTaskProvider.dart';
import 'package:todo_list/model/Task.dart';
class AddTaskPage extends StatelessWidget {
   Task? task;
   AddTaskPage({task}){
     this.task=task;
   }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, provider, x) {
      provider.checkTask(task: task);
      return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
        ),
        body:  Column(children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    key: provider.addNewKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          task==null?
                          Text(
                            " Create Task",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ):Text(
                            " Update Task",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: provider.taskTitleController,
                            decoration: InputDecoration(
                                labelText: "Task Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: TextFormField(
                              controller: provider.taskDetailsController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 80, horizontal: 10.0),
                                  labelText: "task Details",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => {provider.buttonText=="Save"?provider.createTask(context):provider.updateTask(task!,context)},
              child: Text(
                provider.buttonText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ]),
      );
    });
  }
}
