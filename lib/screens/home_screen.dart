import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/tasks_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/widgets/sliver_tasks_list_widget.dart';

import '../widgets/achieved_task_widget.dart';
import '../widgets/high_priority_tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? userImage;
  List<TasksModel> tasks = [];
  bool isLoad = false;
  int totalTask = 0;
  int doneTask = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString("username");
      userImage = PreferencesManager().getString("userImage");
    });
  }

  void _loadTask() async {
    setState(() {
      isLoad = true;
    });

    final getTask = PreferencesManager().getString("tasks");
    if (getTask != null) {
      final taskDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        tasks =
            taskDecode.map((element) => TasksModel.fromJson(element)).toList();
        _calculatePercent();
      });
    }
    setState(() {
      isLoad = false;
    });
  }

  _calculatePercent() {
    totalTask = tasks.length;
    doneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : doneTask / totalTask;
  }

  _doneTasks(bool? val, int? index) async {
    setState(() {
      tasks[index!].isDone = val ?? false;
      _calculatePercent();
    });
    final updateTasks = tasks.map((element) => element.toMap()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
  }

  _deleteTasks(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((element) => element.id == id);
      _calculatePercent();
    });
    final updateTasks = tasks.map((element) => element.toMap()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
            if (result != null && result) {
              _loadTask();
            }
          },
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),

        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImage==null?AssetImage("assets/images/person.png"):FileImage(File(userImage!)),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening ,$username ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "One task at a time.One step closer.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Text(
                    "Yuhuu ,Your work Is ",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        "almost done ! ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SvgPicture.asset("assets/images/waving-hand.svg"),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTaskWidget(
                    totalTask: totalTask,
                    doneTask: doneTask,
                    percent: percent,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasksWidget(
                    refresh: () {
                      _loadTask();
                    },
                    tasks: tasks,

                    onTap: (bool? val, int? index) async {
                      _doneTasks(val, index);
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 24),
                child: Text(
                  "My Tasks",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            if (tasks.isNotEmpty)
              isLoad
                  ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        trackGap: 20,
                        color: Color(0xffFFFCFC),
                      ),
                    ),
                  )
                  : SliverTasksListWidget(
                    tasks: tasks,
                    onTap: (bool? val, int? index) async {
                      _doneTasks(val, index);
                    }, onDelete: (int? id) {
                      _deleteTasks(id);
              }, onEdit:  ()=> _loadTask(),
                  ),
          ],
        ),
      ),
    );
  }
}
