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
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("Sort By"),
        ),
        DropdownButton(
          underline: Container(
              height: 1, color: Theme.of(context).colorScheme.outline),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          onChanged: (_) {},
          value: value == SortType.dateCreated ? "Date Created" : "Date Edited",
          items: [
            DropdownMenuItem(
                value: "Date Created",
                child: const Text("Date Created"),
                onTap: () => onChanged(SortType.dateCreated)),
            DropdownMenuItem(
                value: "Date Edited",
                child: const Text("Date Edited"),
                onTap: () => onChanged(SortType.dateEdited)),
          ],
        )
      ],
    );
  }
}
