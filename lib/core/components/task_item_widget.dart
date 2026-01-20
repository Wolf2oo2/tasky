import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constonts/storage_key.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/enum/tasks_item_actions_enum.dart';
import 'package:tasky/models/tasks_model.dart';

import '../services/preferences_manager.dart';
import '../widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TasksModel tasks;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tasks.taskDescription.isNotEmpty ? 72 : 58,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              ThemeController.isLight()
                  ? Color(0xffd1dad6)
                  : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          CustomCheckBox(
            value: tasks.isDone,
            onChanged: (bool? val) {
              onChanged(val);
            },
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  maxLines: 1,
                  tasks.taskName,
                  style:
                      tasks.isDone
                          ? Theme.of(context).textTheme.titleLarge
                          : Theme.of(context).textTheme.titleMedium,
                ),
                if (tasks.taskDescription.isNotEmpty)
                  Text(
                    maxLines: 1,
                    tasks.taskDescription,
                    style:
                        tasks.isDone
                            ? Theme.of(context).textTheme.titleLarge
                            : Theme.of(context).textTheme.titleMedium,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TasksItemActionsEnum>(
            onSelected: (value)async {
              switch (value) {
                case TasksItemActionsEnum.markAsDone:
                  onChanged(!tasks.isDone);

                case TasksItemActionsEnum.edit:
                final res = await _showModalBottomSheet(context, tasks);
                if(res==true ){
                  onEdit();
                };
                case TasksItemActionsEnum.delete:
                  await _showAlertDialog(context);

                // onDelete(tasks.id);
              }
            },
            icon: Icon(
              Icons.more_vert,
              color:
                  ThemeController.isLight()
                      ? (tasks.isDone ? Color(0xff6A6A6A) : Color(0xff3A4640))
                      : (tasks.isDone ? Color(0xffA0A0A0) : Color(0xffC6C6C6)),
            ),
            itemBuilder:
                (context) =>
                    TasksItemActionsEnum.values
                        .map(
                          (e) => PopupMenuItem<TasksItemActionsEnum>(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
          ),
        ],
      ),
    );
  }

 Future<bool?> _showModalBottomSheet(context, TasksModel model) {
    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        TextEditingController taskNameController = TextEditingController(
          text: model.taskName,
        );
        TextEditingController taskDescriptionController = TextEditingController(
          text: model.taskDescription,
        );
        GlobalKey<FormState> key = GlobalKey();
        bool isHighPriority = model.isHighPriority;
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setState,
          ) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            CustomTextFormField(
                              title: "Task Name",
                              controller: taskNameController,

                              hintText: "Finish UI design for login screen",
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Please Enter Task Description ";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            SizedBox(height: 8),
                            CustomTextFormField(
                              title: "Task Description",
                              controller: taskDescriptionController,
                              maxLines: 5,
                              hintText:
                                  "Finish onboarding UI and hand off to devs by Thursday.",
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority",
                                  style: Theme.of(context).textTheme.titleMedium
                                ),
                                Switch(
                                  value: isHighPriority,
                                  onChanged: (val) {
                                    setState(() {
                                      isHighPriority = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                         if (key.currentState?.validate() ?? false) {
                           final getJson = PreferencesManager()
                               .getString(StorageKey.tasks);
                          List<dynamic> listTasks = [];
                           if (getJson != null) {
                             listTasks = jsonDecode(getJson);
                           }
                          final TasksModel newModel = TasksModel(
                           id:model.id,
                            taskName: taskNameController.text,
                             taskDescription: taskDescriptionController
                                 .text,
                             isHighPriority: isHighPriority,
                            isDone: model.isDone
                           );
                         final item =  listTasks.firstWhere((e) {
                             return e["id"]==model.id;
                           } ,);
                        final int index = listTasks.indexOf(item);
                        listTasks[index]=newModel.toMap();

                        final taskEncode = jsonEncode(listTasks);
                           await PreferencesManager().setString(
                             StorageKey.tasks,
                             taskEncode,
                           );
                           Navigator.of(context).pop(true);
                         }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      label: Text("Edit Task"),
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _showAlertDialog(context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Delete Task"),
            content: Text("Are you sure you want to delete this task?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text("Cansel"),
              ),
              TextButton(
                onPressed: () {
                  onDelete(tasks.id);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text("Delete"),
              ),
            ],
          ),
    );
  }
}
