import 'dart:math';

import 'package:flutter/material.dart';

// A ListView that fades out at the top and/or bottom while scrolling
class FadingListView extends StatefulWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final double gradientHeight;
  final bool top, bottom;
  final EdgeInsetsGeometry? padding;
  final int? itemCount;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  const FadingListView({
    super.key,
    this.controller,
    this.physics,
    this.gradientHeight = 20.0,
    this.top = true,
    this.bottom = true,
    this.padding,
    required this.itemBuilder,
    this.itemCount,
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
      ..addListener(
        () {
          final newStartGradientHeight = min(
            widget.gradientHeight,
            _scrollController.offset,
          );
          final newEndGradientHeight = min(
            widget.gradientHeight,
            _scrollController.position.maxScrollExtent -
                _scrollController.offset,
          );

          if ((widget.top && newStartGradientHeight != startGradientHeight) ||
              (widget.bottom && newEndGradientHeight != endGradientHeight)) {
            setState(
              () {
                startGradientHeight = newStartGradientHeight;
                endGradientHeight = newEndGradientHeight;
              },
            );
          }
        },
      );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () => endGradientHeight = min(
          widget.gradientHeight,
          _scrollController.position.maxScrollExtent - _scrollController.offset,
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (final rect) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            if (widget.top) ...[
              Colors.black,
              Colors.transparent,
            ],
            if (widget.bottom) ...[
              Colors.transparent,
              Colors.black,
            ]
          ],
          stops: [
            if (widget.top) ...[
              0,
              startGradientHeight / rect.height,
            ],
            if (widget.bottom) ...[
              1 - (endGradientHeight / rect.height),
              1,
            ]
          ],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
        child: ListView.builder(
          controller: _scrollController,
          physics: widget.physics,
          padding: widget.padding,
          itemBuilder: widget.itemBuilder,
          itemCount: widget.itemCount,
        ),
      );
}
