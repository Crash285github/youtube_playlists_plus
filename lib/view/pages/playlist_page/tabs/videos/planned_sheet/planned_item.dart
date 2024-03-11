import 'package:flutter/material.dart';

class PlannedItem extends StatelessWidget {
  final String playlistId;
  final String text;
  const PlannedItem({
    super.key,
    required this.playlistId,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 2.0, bottom: 2.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          overlayColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.primary.withOpacity(.3),
          ),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
