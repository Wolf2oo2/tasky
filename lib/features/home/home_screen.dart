import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/constonts/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/features/home/components/achieved_task_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_tasks_list_widget.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/models/tasks_model.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Consumer<HomeController>(builder: (context, value, child) {
        final controller = context.read<HomeController>();

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
                  controller.loadTask();
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
            padding: const EdgeInsetsDirectional.only(
                top: 16, start: 16, end: 16),

            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: value.userImage == null
                                ? AssetImage("assets/images/person.png")
                                : FileImage(File(value.userImage!)),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Evening ,${value.username} ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                              Text(
                                "One task at a time.One step closer.",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                      Text(
                        "Yuhuu ,Your work Is ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            "almost done ! ",
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge,
                          ),
                          SvgPicture.asset("assets/images/waving-hand.svg"),
                        ],
                      ),
                      SizedBox(height: 16),
                      AchievedTaskWidget(
                        totalTask: value.totalTask,
                        doneTask: value.doneTask,
                        percent: value.percent,
                      ),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(
                        refresh: () {
                          controller.loadTask();
                        },
                        tasks: value.tasks,

                        onTap: (bool? val, int? index) async {
                          value.doneTasks(val, index);
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelSmall,
                    ),
                  ),
                ),
                if (value.tasks.isNotEmpty)
                  value.isLoad
                      ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        trackGap: 20,
                        color: Color(0xffFFFCFC),
                      ),
                    ),
                  )
                      : SliverTasksListWidget(
                    tasks: value.tasks,
                    onTap: (bool? val, int? index) async {
                      controller.doneTasks(val, index);
                    }, onDelete: (int? id) {
                    controller.deleteTasks(id);
                  }, onEdit: () => controller.loadTask(),
                  ),
              ],
            ),


          ),
        );
      })



    );
  }
}
