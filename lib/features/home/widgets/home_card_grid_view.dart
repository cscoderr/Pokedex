import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
import 'package:pokedex/features/home/home.dart';

class HomeCardGridView extends StatefulWidget {
  const HomeCardGridView({super.key});

  @override
  State<HomeCardGridView> createState() => _HomeCardGridViewState();
}

class _HomeCardGridViewState extends State<HomeCardGridView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final homeState = ref.watch(homeProvider);
        if (homeState.status == AppStatus.loading) {
          return const SliverToBoxAdapter(
            child: HomeCardShimmer(),
          );
        } else if (homeState.status == AppStatus.failure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                'error'.toString(),
              ),
            ),
          );
        }
        return SliverGrid(
          // controller: _scrollController,
          key: ValueKey('__list_${homeState.data.results}__'),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.6,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: homeState.data.results?.length,
            (BuildContext context, int index) {
              final pokemon = homeState.data.results![index];
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
          // itemCount: data.results?.length,
          // itemBuilder:
        );
      },
    );
  }
}
