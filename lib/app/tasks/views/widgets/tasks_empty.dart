import 'package:flutter/material.dart';

import '../../../../utils/constants/dimens.dart';

class TasksEmpty extends StatelessWidget {
  const TasksEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/undraw_completed-tasks_1j9z 2.png",
          height: 200,
        ),
        SizedBox(
          height: Dimens.spacing.medium,
        ),
        Text(
          "You don't have any tasks yet",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
