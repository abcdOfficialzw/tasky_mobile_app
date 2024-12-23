import 'package:flutter/material.dart';

import '../../../../utils/constants/dimens.dart';
import '../widgets/tasks_empty.dart';
import '../widgets/tasks_search.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.padding.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TasksSearch(),
              SizedBox(
                height: Dimens.spacing.extremeSpacing,
              ),
              const TasksEmpty(),
            ],
          ),
        ),
      ),
    );
  }
}
