import 'dart:math';

import 'package:flutter/material.dart';

class FadingListView extends StatefulWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final double gradientHeight;
  final bool? top;
  final bool? bottom;
  const FadingListView({
    super.key,
    this.controller,
    this.physics,
    this.gradientHeight = 20.0,
    this.children = const [],
    this.top,
    this.bottom,
  }) : assert(top != false || bottom != false);

  @override
  State<FadingListView> createState() => _FadingListViewState();
}

class _FadingListViewState extends State<FadingListView> {
  double startGradientHeight = 0.0;
  late double endGradientHeight = widget.gradientHeight;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = (widget.controller ?? ScrollController())
      ..addListener(() => setState(() {
            startGradientHeight =
                min(widget.gradientHeight, _scrollController.offset);
            endGradientHeight = min(
                widget.gradientHeight,
                _scrollController.position.maxScrollExtent -
                    _scrollController.offset);
          }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      shaderCallback: (final rect) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if (widget.top ?? true) ...[
              Colors.black,
              Colors.transparent,
            ],
            if (widget.bottom ?? true) ...[Colors.transparent, Colors.black]
          ],
          stops: [
            if (widget.top ?? true) ...[
              5 / rect.height,
              startGradientHeight / rect.height,
            ],
            if (widget.bottom ?? true) ...[
              1 - (endGradientHeight / rect.height),
              1 - (5 / rect.height)
            ]
          ]).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
      child: ListView(
        controller: _scrollController,
        physics: widget.physics,
        padding: const EdgeInsets.symmetric(vertical: 0),
        children: widget.children,
      ),
    );
  }
}
