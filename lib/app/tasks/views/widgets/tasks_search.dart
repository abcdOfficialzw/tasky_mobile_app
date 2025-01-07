import 'package:flutter/material.dart';

import '../../../../utils/constants/dimens.dart';

class TasksSearch extends StatelessWidget {
  final void Function(String searchString) onSearch;
  const TasksSearch({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Tasks",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: Dimens.spacing.small,
        ),
        // Search field
        TextField(
          onChanged: onSearch,
          decoration: InputDecoration(
            hintText: "Search tasks",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.borderRadius.small),
            ),
          ),
        ),
      ],
    );
  }
}
