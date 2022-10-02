import 'package:pokedex/core/core.dart';

class Stat {
  Stat({
    this.name,
    this.url,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: PokemonStat.mapValueToStat(json['name'] as String),
        url: json['url'] as String,
      );

  final PokemonStat? name;
  final String? url;
}
