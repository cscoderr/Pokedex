class PokemonType {
  PokemonType({
    required this.name,
    required this.url,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        name: json['name'] as String,
        url: json['url'] as String,
      );

  final String? name;
  final String? url;
}
