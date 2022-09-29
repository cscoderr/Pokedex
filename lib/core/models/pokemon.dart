class Pokemon {
  const Pokemon({
    this.name,
    this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json['name'] as String?,
        url: json['url'] as String?,
      );

  final String? name;
  final String? url;
}

extension PokemonExtension on Pokemon {
  String get id {
    final data = url?.split('/');
    data?.removeLast();
    return data?.last ?? '1';
  }

  String get getImageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
