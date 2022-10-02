// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/details/details.dart';
import 'package:pokedex/features/home/home.dart';

class HomeCardGridView extends StatelessWidget {
  const HomeCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final homeState = ref.watch(homeProvider);
        if (homeState.status == HomeStatus.loading) {
          return const SliverToBoxAdapter(
            child: HomeCardShimmer(),
          );
        } else if (homeState.status == HomeStatus.error) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.info),
                  const SizedBox(height: 5),
                  Text(
                    homeState.errorMessage,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          );
        } else if (homeState.status == HomeStatus.searchSuccess) {
          return HomeCardGrid(
            data: homeState.dataSearch,
          );
        }
        return HomeCardGrid(data: homeState.data.results);
      },
    );
  }
}

class HomeCardGrid extends StatelessWidget {
  const HomeCardGrid({
    super.key,
    required this.data,
  });

  final List<Pokemon>? data;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      key: ValueKey('__list_${data}__'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.65,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: data?.length,
        (BuildContext context, int index) {
          final pokemon = data![index];
          return FadeAmination(
            isEven: index.isEven,
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
    );
  }
}
