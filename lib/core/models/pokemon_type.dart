import 'package:flutter/foundation.dart';

@immutable
class PokemonType {
  const PokemonType({
    required this.name,
    required this.url,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        name: json['name'] as String,
        url: json['url'] as String,
      );

  final String? name;
  final String? url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonType &&
          other.runtimeType == runtimeType &&
          other.name == name &&
          other.url == url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
