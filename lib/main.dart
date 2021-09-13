import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ui/Pages/HomePage.dart';
import 'package:todo_list/util/DatabaseHelper.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'Provider/AddTaskProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(ChangeNotifierProvider<TaskProvider>(
    create: (context) => TaskProvider(),
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 400,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(400, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
    ),
  ));
}
