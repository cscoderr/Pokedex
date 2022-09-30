import 'package:pokedex/core/core.dart';

class Types {
  Types({
    this.type,
    this.slot,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        slot: json['slot'] as int?,
        type: PokemonType.fromJson(json['type'] as Map<String, dynamic>),
      );
  final int? slot;
  final PokemonType? type;
}
