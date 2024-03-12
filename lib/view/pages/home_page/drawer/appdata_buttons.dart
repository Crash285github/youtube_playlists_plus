import 'package:flutter/material.dart';

class AppDataButtons extends StatelessWidget {
  const AppDataButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Template(
          onTap: () {},
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          children: const [
            Icon(Icons.download_outlined),
            Text("Export"),
          ],
        ),
        const SizedBox(width: 32),
        _Template(
          onTap: () {},
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
          children: const [
            Text("Import"),
            Icon(Icons.upload_outlined),
          ],
        )
      ],
    );
  }
}

class _Template extends StatelessWidget {
  final BorderRadius borderRadius;
  final void Function()? onTap;
  final List<Widget> children;
  const _Template({
    required this.borderRadius,
    required this.children,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.primary.withOpacity(.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
