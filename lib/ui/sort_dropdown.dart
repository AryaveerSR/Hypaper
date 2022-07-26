import 'package:flutter/material.dart';

enum SortType { dateCreated, dateEdited }

class SortDropdown extends StatelessWidget {
  final Function(SortType) onChanged;
  final SortType value;
  const SortDropdown({Key? key, required this.onChanged, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            "Sort By",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        DropdownButton(
          style: Theme.of(context).textTheme.bodyMedium,
          elevation: 0,
          onChanged: (_) {},
          value: value == SortType.dateCreated ? "Date Created" : "Date Edited",
          items: [
            DropdownMenuItem(
                value: "Date Created",
                child: Text(
                  "Date Created",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () => onChanged(SortType.dateCreated)),
            DropdownMenuItem(
                value: "Date Edited",
                child: Text(
                  "Date Edited",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () => onChanged(SortType.dateEdited)),
          ],
        )
      ],
    );
  }
}
