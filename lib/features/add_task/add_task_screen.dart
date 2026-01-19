import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/tasks_model.dart';

import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task"), leadingWidth: 35),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                      if (_key.currentState?.validate() ?? false) {
                        final getJson = PreferencesManager().getString("tasks");
                        List<dynamic> listTasks = [];
                        if (getJson != null) {
                          listTasks = jsonDecode(getJson);
                        }
                        final TasksModel model = TasksModel(
                          id: listTasks.length + 1,
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );

                        listTasks.add(model.toMap());

                        final taskEncode = jsonEncode(listTasks);
                        await PreferencesManager().setString(
                          "tasks",
                          taskEncode,
                        );
                        Navigator.of(context).pop(true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    label: Text("Add Task"),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
