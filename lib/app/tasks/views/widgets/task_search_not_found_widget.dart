import 'package:flutter/material.dart';

import '../../../../utils/constants/dimens.dart';

class TaskSearchNotFoundWidget extends StatelessWidget {
  const TaskSearchNotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/undraw_the-search_cjxa 1.png",
          height: 200,
        ),
        SizedBox(
          height: Dimens.spacing.medium,
        ),
        Text(
          "We couldn't find that task🥲, try searching for something else",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
