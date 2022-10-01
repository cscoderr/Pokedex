import 'package:flutter/foundation.dart';
import 'package:pokedex/core/core.dart';

@immutable
class HomeState {
  const HomeState({
    this.status = AppStatus.loading,
    this.offset = 0,
    this.data = const PokemonResponse(),
  });

  HomeState copWith({
    AppStatus? status,
    int? offset,
    PokemonResponse? data,
  }) {
    return HomeState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          offset == other.offset &&
          data == other.data;

  @override
  int get hashCode => status.hashCode ^ offset.hashCode ^ data.hashCode;

  final AppStatus status;
  final int offset;
  final PokemonResponse data;
}
