import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/core/core.dart';

class PokedexSilverAppBar extends StatefulWidget {
  const PokedexSilverAppBar({
    super.key,
    required this.imageColor,
    required this.pokemon,
    required this.scrollController,
  });

  final PaletteGenerator? imageColor;
  final Pokemon pokemon;
  final ScrollController scrollController;

  @override
  State<PokedexSilverAppBar> createState() => _PokedexSilverAppBarState();
}

class _PokedexSilverAppBarState extends State<PokedexSilverAppBar> {
  double _titleOpacity = 0;
  void scrollControllerListener() {
    final pixel = widget.scrollController.position.pixels;

    if (pixel > (300 - 70)) {
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
      expandedHeight: 300,
      collapsedHeight: 60,
      backgroundColor: widget.imageColor?.dominantColor?.color,
      shape: _titleOpacity == 0
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          : null,
      pinned: true,
      title: AnimatedOpacity(
        opacity: _titleOpacity,
        duration: const Duration(milliseconds: 500),
        child: Text(
          widget.pokemon.name!.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: ValueKey('__pokemon_image_${widget.pokemon.id}__'),
          child: CachedNetworkImage(
            imageUrl: widget.pokemon.getImageUrl,
          ),
        ),
      ),
    );
  }
}
