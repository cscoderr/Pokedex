import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

class HomeProvider extends StateNotifier<AsyncValue<PokemonResponse>> {
  HomeProvider(this.ref) : super(const AsyncData(PokemonResponse())) {
    getPokemonList();
  }

  final Reader ref;

  Future<void> getPokemonList() async {
    state = const AsyncLoading();
    final result = await ref(pokedexRepositoryProvider).getPokemonList();
    state = AsyncData(result);
  }
}

final homeProvider =
    StateNotifierProvider<HomeProvider, AsyncValue<PokemonResponse>>((ref) {
  return HomeProvider(ref.read);
});
