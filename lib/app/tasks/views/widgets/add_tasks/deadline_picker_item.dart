import 'package:flutter/material.dart';

import '../../../../../utils/constants/dimens.dart';

class DeadlinePickerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool selected;
  final Function()? onSelect;
  const DeadlinePickerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.selected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.all(Dimens.padding.small),
        decoration: BoxDecoration(
          color:
              selected ? Theme.of(context).colorScheme.primaryContainer : null,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Dimens.borderRadius.small),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              width: Dimens.padding.small,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
