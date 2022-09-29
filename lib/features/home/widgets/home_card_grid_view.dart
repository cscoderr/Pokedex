import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
import 'package:pokedex/features/home/home.dart';

class HomeCardGridView extends ConsumerStatefulWidget {
  const HomeCardGridView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeCardGridViewState();
}

class _HomeCardGridViewState extends ConsumerState<HomeCardGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(homeProvider);
    return pokemonList.when(
      data: (data) => GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.6,
        ),
        itemCount: data.results?.length,
        itemBuilder: (BuildContext context, int index) {
          final pokemon = data.results![index];
          return FadeAmination(
            delay: (index * 1.5) * 50,
            child: HomeCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(pokemon: pokemon),
                  ),
                );
              },
              id: pokemon.id,
              imageUrl: pokemon.getImageUrl,
              name: pokemon.name!,
            ),
          );
        },
      ),
      error: (error, __) => Text(error.toString()),
      loading: HomeCardShimmer.new,
    );
  }
}
