import 'package:flutter/material.dart';

class PokedexSilverAppBar extends StatefulWidget {
  const PokedexSilverAppBar({
    super.key,
    required this.scrollController,
    required this.title,
    this.backgroundColor,
    this.flexibleSpace,
    this.expandedHeight = 300,
    this.collapsedHeight = 70,
  });

  final double expandedHeight;
  final double collapsedHeight;
  final Widget title;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final ScrollController scrollController;

  @override
  State<PokedexSilverAppBar> createState() => _PokedexSilverAppBarState();
}

class _PokedexSilverAppBarState extends State<PokedexSilverAppBar> {
  double _titleOpacity = 0;
  void scrollControllerListener() {
    final pixel = widget.scrollController.position.pixels;

    if (pixel > (widget.expandedHeight - widget.collapsedHeight)) {
      _titleOpacity = 1;
      setState(() {});
    } else {
      _titleOpacity = 0;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(scrollControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      elevation: 0,
      collapsedHeight: widget.collapsedHeight,
      backgroundColor: widget.backgroundColor ?? Colors.white,
      shape: _titleOpacity == 0
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          : null,
      pinned: true,
      title: AnimatedOpacity(
        opacity: _titleOpacity,
        duration: const Duration(milliseconds: 500),
        child: widget.title,
      ),
      flexibleSpace: widget.flexibleSpace,
    );
  }
}
