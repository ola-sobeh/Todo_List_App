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
    return Consumer<AddTaskProvider>(builder: (context, provider, x) {
      String taskTitle;
      String taskDetails;
      String buttonText;
      if(task==null){
        taskTitle="Task Title";
         taskDetails="Task Details";
         buttonText="Save";
      }else{
        taskTitle=task!.title;
        taskDetails=task!.Details;
        buttonText="Update";
      }
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
                                labelText: taskTitle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: provider.taskDetailsController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 80, horizontal: 10.0),
                                labelText: taskDetails,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () => {buttonText=="Save"?provider.createTask():provider.updateTask(task!)},
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ]),
      );
    });
  }
}
