import 'package:flutter/material.dart';
import 'package:pokedex/core/core.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        0,
        15,
        0,
        MediaQuery.of(context).padding.bottom - 20,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Hero(
              tag: ValueKey('__pokemon_title_${pokemon.id}__'),
              child: Text(
                pokemon.name!.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Hero(
              tag: ValueKey('__pokemon_id_${pokemon.id}__'),
              child: Text(
                '#${pokemon.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
