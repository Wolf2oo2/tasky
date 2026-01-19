import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/models/tasks_model.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    required this.tasks,
    required this.onTap,
    required this.refresh,
    super.key,
  });

  final List<TasksModel> tasks;
  final Function(bool?, int?) onTap;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ThemeController.isLight()?Color(0xffd1dad6):Colors.transparent)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(fontSize: 14, color: Color(0xff15B86C)),
                  ),
                ),
                ...tasks.reversed
                    .where((e) => e.isHighPriority)
                    .take(4)
                    .map(
                      (element) => Row(
                        children: [
                          CustomCheckBox(
                            value: element.isDone,
                            onChanged: (bool? val) {
                              final index = tasks.indexWhere((e) {
                                return e.id == element.id;
                              });
                              onTap(val, index);
                            },
                          ),
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              element.taskName,
                              style: element.isDone?Theme.of(context).textTheme.titleLarge:Theme.of(context).textTheme.titleMedium

                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HighPriorityScreen()),
              );
              refresh();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              height: 56,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(color: ThemeController.isLight()?Color(0xffD1DAD6):Color(0xff6E6E6E)),
              ),
              child: SvgPicture.asset(
                "assets/images/arrow_up.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(ThemeController.isLight()?Color(0xff3A4640):Color(0xffC6C6C6), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
