import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              15,
              0,
              MediaQuery.of(context).padding.bottom - 20,
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
                                        imageColor?.paletteColors.last.color ??
                                            Colors.grey,
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
                      _percentageIndicator(
                        percentage: data.height!,
                        title: 'HP',
                        textStyle: textStyle,
                        progressColor: mainColor,
                      ),
                      const SizedBox(height: 15),
                      _percentageIndicator(
                        percentage: data.height!,
                        title: 'ATK',
                        textStyle: textStyle,
                        progressColor: mainColor,
                      ),
                      const SizedBox(height: 15),
                      _percentageIndicator(
                        percentage: data.height!,
                        title: 'DEF',
                        textStyle: textStyle,
                        progressColor: mainColor,
                      ),
                      const SizedBox(height: 15),
                      _percentageIndicator(
                        percentage: data.height!,
                        title: 'SPD',
                        textStyle: textStyle,
                        progressColor: mainColor,
                      ),
                      const SizedBox(height: 15),
                      _percentageIndicator(
                        percentage: data.height!,
                        title: 'EXP',
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

  Widget _percentageIndicator({
    required int percentage,
    required String title,
    required TextTheme textStyle,
    required Color progressColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: textStyle.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // const Spacer(),
        Expanded(
          flex: 5,
          child: LinearPercentIndicator(
            // width: MediaQuery.of(context).size.width - 80,
            lineHeight: 25.0,
            percent: percentage / 100,
            center: Text(
              '${percentage / 100}%',
              style: textStyle.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            barRadius: const Radius.circular(20),
            backgroundColor: Colors.grey.withOpacity(0.8),
            progressColor: progressColor,
          ),
        ),
      ],
    );
  }
}
