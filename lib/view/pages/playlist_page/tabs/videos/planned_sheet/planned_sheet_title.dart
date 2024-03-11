import 'package:flutter/material.dart';

class PlannedSheetTitle extends StatelessWidget {
  final void Function()? onTap;
  final int plannedLength;
  const PlannedSheetTitle({
    super.key,
    this.onTap,
    required this.plannedLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 4.0,
            ),
            child: InkWell(
              onTap: onTap,
              overlayColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(6.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Planned ($plannedLength)",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(indent: 16.0, endIndent: 16.0)
      ],
    );
  }
}
