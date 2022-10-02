import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

// class DetailsProvider extends StateNotifier<AsyncValue<PokemonDetails>> {
//   DetailsProvider(this.ref) : super(AsyncData(PokemonDetails()));

//   final Reader ref;

//   Future<void> getPokemonList(String name) async {
//     state = const AsyncLoading();
//     final result = await ref(pokedexRepositoryProvider).getPokemonDetails(name);
//     state = AsyncData(result);
//   }
// }

final detailsProvider =
    FutureProvider.family<PokemonDetails, String>((ref, name) async {
  final response =
      await ref.read(pokedexRepositoryProvider).getPokemonDetails(name);
  return response;
});

final detailTitleOpacityProvider = StateProvider<bool>((ref) {
  return false;
});

// final homeProvider =
//     StateNotifierProvider<DetailsProvider, AsyncValue<PokedomDetails>>((ref) {
//   return DetailsProvider(ref.read);
// });
