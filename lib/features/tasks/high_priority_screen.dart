import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

import '../../models/tasks_model.dart';
import '../../core/components/tasks_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TasksModel> tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    final finalTasks = PreferencesManager().getString("tasks");
    if (finalTasks != null) {
      final tasksDecode = jsonDecode(finalTasks) as List<dynamic>;
      setState(() {
        tasks =
            tasksDecode
                .map((element) => TasksModel.fromJson(element))
                .where((e) => e.isHighPriority)
                .toList();

      });
    }
  }  _deleteTasks(int? id) async {
    List<TasksModel> model =[];
    if (id == null) return;
    final finalTasks = PreferencesManager().getString("tasks");
    if (finalTasks != null) {
      final tasksDecode = jsonDecode(finalTasks) as List<dynamic>;
      model=tasksDecode.map((e) => TasksModel.fromJson(e),).toList();
      model.removeWhere((element) => element.id==id,);

      setState(() {
        tasks.removeWhere((element) => element.id == id);
      });
      final updateTasks = model.map((element) => element.toMap()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
    }}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: TasksListWidget(
            tasks: tasks,
            onTap: (bool? val, int? index) async {
              setState(() {
                tasks[index!].isDone = val ?? false;
              });

              final allData = PreferencesManager().getString('tasks');
              if (allData != null) {
                List<TasksModel> allDataList =
                    (jsonDecode(allData) as List)
                        .map((element) => TasksModel.fromJson(element))
                        .toList();
                final newIndex = allDataList.indexWhere(
                  (e) => e.id == tasks[index!].id,
                );
                allDataList[newIndex] = tasks[index!];
                final encodeData = allDataList.map((e) => e.toMap()).toList();

                await PreferencesManager().setString("tasks", jsonEncode(encodeData));
                _loadTasks();
              }
            }, onDelete: (int? id) { _deleteTasks(id); }, onEdit:  ()=> _loadTasks(),
          ),
        ),
      ),
    );
  }
}
