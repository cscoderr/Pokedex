import 'package:flutter/foundation.dart';
import 'package:pokedex/core/core.dart';

@immutable
class Types {
  const Types({
    this.type,
    this.slot,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        slot: json['slot'] as int?,
        type: PokemonType.fromJson(json['type'] as Map<String, dynamic>),
      );
  final int? slot;
  final PokemonType? type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Types &&
          other.runtimeType == runtimeType &&
          other.slot == slot &&
          other.type == type;

  @override
  int get hashCode => type.hashCode ^ slot.hashCode;
}
