import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(const HomeState()) {
    getPokemonList();
  }

  final Reader ref;

  int limit = 20;

  Future<void> getPokemonList() async {
    try {
      state = state.copWith(status: AppStatus.loading);
      final response = await ref(pokedexRepositoryProvider)
          .getPokemonList(limit: limit, offset: state.offset);
      state = state.copWith(status: AppStatus.success, data: response);
    } catch (e) {
      state = state.copWith(status: AppStatus.failure);
    }
  }
}

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref.read);
});
