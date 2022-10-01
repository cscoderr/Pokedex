import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
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
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final imageColor =
        ref.watch(imageColorProvider(widget.pokemon.getImageUrl)).value;
    final details = ref.watch(
      detailsProvider(
        widget.pokemon.name!.toLowerCase(),
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
            imageColor: imageColor,
            pokemon: widget.pokemon,
            scrollController: scrollController,
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              0,
              10,
              0,
              MediaQuery.of(context).padding.bottom,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    widget.pokemon.name!.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '#${widget.pokemon.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          details.when(
            data: (data) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        children: data.types
                                ?.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Chip(
                                      backgroundColor: imageColor
                                              ?.paletteColors.last.color ??
                                          Colors.grey,
                                      label: Text(
                                        e.type!.name!.capitalize,
                                        style: textStyle.headline6,
                                      ),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),
                    _percentageIndicator(
                      percentage: data.height!,
                      title: 'Height:',
                      textStyle: textStyle,
                      progressColor: mainColor,
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),
                    _percentageIndicator(
                      percentage: data.height!,
                      title: 'Weight:',
                      textStyle: textStyle,
                      progressColor: mainColor,
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    const SizedBox(height: 10),
                    _percentageIndicator(
                      percentage: data.height!,
                      title: 'Based Experience:',
                      textStyle: textStyle,
                      progressColor: mainColor,
                    ),
                  ],
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

  Widget _percentageIndicator({
    required int percentage,
    required String title,
    required TextTheme textStyle,
    required Color progressColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: textStyle.headline6!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 40,
            lineHeight: 25.0,
            percent: percentage / 100,
            center: Text(
              '${percentage / 100}%',
              style: textStyle.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            barRadius: const Radius.circular(20),
            backgroundColor: Colors.grey.withOpacity(0.8),
            progressColor: progressColor,
          ),
        ],
      ),
    );
  }
}

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
