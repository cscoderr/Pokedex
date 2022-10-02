import 'package:flutter/foundation.dart';
import 'package:pokedex/core/core.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
  searchSuccess,
  loadMore,
  loadMoreError,
}

@immutable
class HomeState {
  const HomeState({
    this.status = HomeStatus.loading,
    this.offset = 0,
    this.errorMessage = '',
    this.dataSearch = const [],
    this.data = const PokemonResponse(),
  });

  HomeState copWith({
    HomeStatus? status,
    int? offset,
    PokemonResponse? data,
    List<Pokemon>? dataSearch,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      data: data ?? this.data,
      dataSearch: dataSearch ?? this.dataSearch,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          offset == other.offset &&
          data == other.data &&
          listEquals(dataSearch, other.dataSearch) &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^
      offset.hashCode ^
      data.hashCode ^
      errorMessage.hashCode ^
      dataSearch.hashCode;

  final HomeStatus status;
  final int offset;
  final String errorMessage;
  final PokemonResponse data;
  final List<Pokemon> dataSearch;
}
