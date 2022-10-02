enum PokemonStat {
  hp('hp'),
  attack('atk'),
  defense('def'),
  specialAttack('sa'),
  specialDefense('sd'),
  speed('spd'),
  unknown('');

  const PokemonStat(this.initial);
  final String initial;

  String get name {
    return toString().split('.').last;
  }

  static PokemonStat mapValueToStat(String value) {
    if (value == 'hp') {
      return PokemonStat.hp;
    } else if (value == 'attack') {
      return PokemonStat.attack;
    } else if (value == 'defense') {
      return PokemonStat.defense;
    } else if (value == 'special-attack') {
      return PokemonStat.specialAttack;
    } else if (value == 'special-defense') {
      return PokemonStat.specialDefense;
    } else if (value == 'speed') {
      return PokemonStat.speed;
    } else {
      return PokemonStat.unknown;
    }
  }
}
