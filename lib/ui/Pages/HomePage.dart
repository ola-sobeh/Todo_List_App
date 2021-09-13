import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Provider/AddTaskProvider.dart';
import 'package:todo_list/model/Task.dart';
import 'package:todo_list/ui/Pages/AddTaskPage.dart';
import 'package:todo_list/ui/Widget/TaskWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Consumer<TaskProvider>(builder: (context, provider, x) {
          List<Task>? tasks = provider.allTask;
          return Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  color: Colors.indigo,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(28, 43, 0, 0),
                        child: Column(children: [
                          Text(
                            "Today",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Text(
                            "Tasks",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ]),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddTaskPage()))
                        },
                        child: Text(
                          "Add New",
                          style: TextStyle(color: Colors.indigo),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.white,
                            minimumSize: Size(45.0, 45.0)),
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 70.0,
                          lineWidth: 6.0,
                          animation: true,
                          percent: provider.getProgressPercentage() / 100,
                          center: Text(
                            (provider.getProgressPercentage())
                                    .toStringAsFixed(1) +
                                "%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.indigo,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Progress",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  "${provider.getTotalCompleteTask()}/${provider.totalTaskNum} tasks done ",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey<Task>(tasks[index]),
                            child: TaskWidget(tasks[index]),
                            onDismissed: (DismissDirection direction) {
                              provider.deleteTask(tasks[index]);
                            },
                            background: Container(
                              color: Colors.white,
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: Align(
                                child: Icon(Icons.cancel, color: Colors.black),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
