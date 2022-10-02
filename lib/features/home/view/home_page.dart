import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      final bottom = MediaQuery.of(context).size.height * 0.20;
      if ((scrollController.position.maxScrollExtent -
              scrollController.position.pixels) <=
          bottom) {
        ref.read(homeProvider.notifier).getPokemonList(isInitial: false);
      }
    });
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeProvider.notifier).getPokemonList(),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            PokedexSilverAppBar(
              scrollController: scrollController,
              expandedHeight: 210,
              title: const SearchBox(),
              flexibleSpace: _flexibleSpace(context),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                MediaQuery.of(context).padding.bottom,
              ),
              sliver: const HomeCardGridView(),
            ),
            const LoadMoreWidget(),
          ],
        ),
      ),
    );
  }

  Widget _flexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      background: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            width: 200,
            child: Hero(
              tag: const ValueKey('__pokedex__'),
              child: Image.asset(
                'assets/images/pokedex.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '''Search for Pokémon by name or using the National Pokédex number.''',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchBox(),
          ),
        ],
      ),
    );
  }
}
