import 'package:flutter/material.dart';

class PokedexSilverAppBar extends StatelessWidget {
  const PokedexSilverAppBar({
    super.key,
    required this.scrollController,
    required this.title,
    this.backgroundColor,
    this.flexibleSpace,
    this.expandedHeight = 300,
    this.collapsedHeight = 70,
    this.titleOpacity = false,
  });

  final double expandedHeight;
  final double collapsedHeight;
  final Widget title;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final ScrollController scrollController;
  final bool titleOpacity;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      elevation: 0,
      collapsedHeight: collapsedHeight,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: !titleOpacity
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          : null,
      title: AnimatedOpacity(
        opacity: titleOpacity ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: title,
      ),
      flexibleSpace: flexibleSpace,
    );
  }
}
