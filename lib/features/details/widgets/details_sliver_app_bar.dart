import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';

class DetailsSliverAppbar extends ConsumerWidget {
  const DetailsSliverAppbar({
    super.key,
    this.imageColor,
    required this.scrollController,
    required this.pokemon,
  });

  final PaletteGenerator? imageColor;
  final ScrollController scrollController;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleOpacity = ref.watch(detailTitleOpacityProvider);
    return PokedexSilverAppBar(
      titleOpacity: titleOpacity,
      backgroundColor:
          imageColor?.dominantColor?.color ?? const Color(0xFFB8DFCA),
      scrollController: scrollController,
      collapsedHeight: 60,
      title: Text(
        pokemon.name!.toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: ValueKey('__pokemon_image_${pokemon.id}__'),
          child: CachedNetworkImage(
            imageUrl: pokemon.getImageUrl,
          ),
        ),
      ),
    );
  }
}
