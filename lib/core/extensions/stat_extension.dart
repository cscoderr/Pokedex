import 'package:pokedex/core/core.dart';

extension PokemonStatExtension on PokemonStat {
  String get subName {
    return initial.toUpperCase();
  }
}
