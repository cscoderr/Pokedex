import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final imageColor =
        ref.watch(imageColorProvider(widget.pokemon.getImageUrl)).value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: imageColor?.dominantColor?.color,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: ValueKey('__pokemon_image_${widget.pokemon.id}__'),
                child: CachedNetworkImage(
                  imageUrl: widget.pokemon.getImageUrl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
