import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
class AchievedTaskWidget extends StatelessWidget {
  const AchievedTaskWidget({
   required this.totalTask,
   required this.doneTask,
   required this.percent,

    super.key,
  });
final int totalTask;
final int doneTask;
final double percent;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ThemeController.isLight()?Color(0xffd1dad6):Colors.transparent)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium
              ),
              SizedBox(height: 4),
              Text(
                "$doneTask Out of $totalTask Done",
                  style: Theme.of(context).textTheme.titleSmall,

              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xff6D6D6D),
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xff15B86C),
                    ),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                "${(percent*100).toInt()}%",
                style: Theme.of(context).textTheme.titleSmall,

              ),
            ],
          ),
        ],
      ),
    );
  }
}
