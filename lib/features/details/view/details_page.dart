import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
import 'package:pokedex/features/home/home.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final pixel = _scrollController.position.pixels;

    if (pixel > (300 - 60)) {
      ref
          .read(detailTitleOpacityProvider.notifier)
          .update((state) => state = true);
    } else {
      ref
          .read(detailTitleOpacityProvider.notifier)
          .update((state) => state = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageColor =
        ref.watch(imageColorProvider(widget.pokemon.getImageUrl)).value;
    final details = ref.watch(
      detailsProvider(
        widget.pokemon.name!.toLowerCase(),
      ),
    );

    final mainColor =
        imageColor?.dominantColor?.color ?? const Color(0xFFB8DFCA);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DetailsSliverAppbar(
            imageColor: imageColor,
            pokemon: widget.pokemon,
            scrollController: _scrollController,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          DetailsTitle(pokemon: widget.pokemon),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          details.when(
            data: (data) {
              return DetailsPageView(
                data: data,
                backgroundColor: imageColor?.paletteColors.last.color,
                progressBarColor: mainColor,
              );
            },
            error: (error, _) => SliverToBoxAdapter(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: PokdexLoader(),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPageView extends StatelessWidget {
  const DetailsPageView({
    super.key,
    required this.data,
    required this.progressBarColor,
    this.backgroundColor,
  });

  final PokemonDetailResponse data;
  final Color? backgroundColor;
  final Color progressBarColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                        (e) => FadeAmination(
                          delay: 0.35,
                          child: Chip(
                            backgroundColor:
                                backgroundColor ?? const Color(0xFFB8DFCA),
                            label: Text(
                              e.type!.name!.capitalize,
                              style: theme.textTheme.titleMedium,
                            ),
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
                FadeAmination(
                  delay: 0.4,
                  child: _detailsTile(
                    textStyle: theme.textTheme,
                    title: 'Height',
                    value: data.height?.toString() ?? '0',
                  ),
                ),
                FadeAmination(
                  delay: 0.55,
                  child: _detailsTile(
                    textStyle: theme.textTheme,
                    title: 'Weight',
                    value: data.weight?.toString() ?? '0',
                  ),
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
              FadeAmination(
                delay: 0.45 + (i * 0.1),
                child: PercentageIndicator(
                  percentage: data.stats![i].baseStat!,
                  title: data.stats![i].stat!.name!.subName,
                  textStyle: theme.textTheme,
                  progressColor: progressBarColor,
                ),
              ),
          ],
        ),
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
          style: textStyle.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: textStyle.bodyLarge!.copyWith(),
        ),
      ],
    );
  }
}
