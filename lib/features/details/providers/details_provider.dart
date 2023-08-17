import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

final detailsProvider =
    FutureProvider.family<PokemonDetailResponse, String>((ref, name) async {
  final response =
      await ref.read(pokedexRepositoryProvider).getPokemonDetails(name);
  return response;
});

final detailTitleOpacityProvider = StateProvider<bool>((ref) {
  return false;
});
