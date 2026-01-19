import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/models/tasks_model.dart';


class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TasksModel> tasks;
  final Function(bool?, int?) onTap;
  final Function( int?) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 80),
      sliver: SliverList.separated(
        itemCount: tasks.length,
        itemBuilder:
            (context, index) => TaskItemWidget(
              tasks: tasks[index],
              onChanged: (bool? val) {
                onTap(val, index);
              }, onDelete: ( int id) {
                onDelete(id);
            }, onEdit: onEdit,
            ),
        separatorBuilder:
            (BuildContext context, int index) => SizedBox(height: 8),
      ),
    );
  }
}
