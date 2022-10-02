import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
import 'package:pokedex/features/home/home.dart';

class DetailsPage extends ConsumerWidget {
  DetailsPage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageColor = ref.watch(imageColorProvider(pokemon.getImageUrl)).value;
    final details = ref.watch(
      detailsProvider(
        pokemon.name!.toLowerCase(),
      ),
    );
    final textStyle = Theme.of(context).textTheme;
    final mainColor =
        imageColor?.dominantColor?.color ?? const Color(0xFFB8DFCA);
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          PokedexSilverAppBar(
            backgroundColor: imageColor!.dominantColor!.color,
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
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              0,
              15,
              0,
              MediaQuery.of(context).padding.bottom - 20,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    pokemon.name!.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '#${pokemon.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          details.when(
            data: (data) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 20,
                        children: data.types
                                ?.map(
                                  (e) => Chip(
                                    backgroundColor:
                                        imageColor.paletteColors.last.color,
                                    label: Text(
                                      e.type!.name!.capitalize,
                                      style: textStyle.titleMedium,
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _detailsTile(
                            textStyle: textStyle,
                            title: 'Height',
                            value: data.height?.toString() ?? '0',
                          ),
                          _detailsTile(
                            textStyle: textStyle,
                            title: 'Weight',
                            value: data.weight?.toString() ?? '0',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Stats',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      for (int i = 0; i < data.stats!.length; i++)
                        PercentageIndicator(
                          percentage: data.stats![i].baseStat!,
                          title: data.stats![i].stat!.name!.subName,
                          textStyle: textStyle,
                          progressColor: mainColor,
                        ),
                    ],
                  ),
                ),
              );
            },
            error: (error, _) => SliverToBoxAdapter(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsTile({
    required TextTheme textStyle,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: textStyle.headline5!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: textStyle.bodyText1!.copyWith(),
        ),
      ],
    );
  }
}
