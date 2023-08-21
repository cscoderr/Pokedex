import 'package:flutter/foundation.dart';
import 'package:pokedex/core/core.dart';

@immutable
class Stat {
  const Stat({
    this.name,
    this.url,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: PokemonStat.mapValueToStat(json['name'] as String),
        url: json['url'] as String,
      );

  final PokemonStat? name;
  final String? url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stat &&
          other.runtimeType == runtimeType &&
          other.name == name &&
          other.url == url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
