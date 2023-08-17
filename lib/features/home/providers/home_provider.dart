import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

final homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider(ref)..getPokemonList();
});

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this.ref) : super(const HomeState());

  final Ref ref;
  int limit = 20;

  Future<void> search(String filter) async {
    if (filter.isEmpty) {
      state = state.copWith(
        dataSearch: [],
        status: HomeStatus.success,
      );
      return;
    }
    final search = state.data.results
        ?.where(
          (element) => element.name?.toLowerCase().contains(filter) ?? false,
        )
        .toList();
    if (search!.isNotEmpty) {
      state = state.copWith(
        dataSearch: state.data.copyWith(results: search).results,
        status: HomeStatus.searchSuccess,
      );
    } else {
      state = state.copWith(
        dataSearch: [],
        status: HomeStatus.success,
      );
    }
  }

  Future<void> getPokemonList({bool isInitial = true}) async {
    if (state.status == HomeStatus.loadMore) return;
    try {
      if (isInitial) {
        state = state.copWith(
          offset: 0,
          status: HomeStatus.loading,
        );
      } else {
        state = state.copWith(
          offset: state.offset + limit,
          status: HomeStatus.loadMore,
        );
      }

      final response = await ref
          .read(pokedexRepositoryProvider)
          .getPokemonList(limit: limit, offset: state.offset);

      state = state.copWith(
        status: HomeStatus.success,
        data: isInitial ? response : state.data.append(response),
      );
    } on PokedexFailure catch (e) {
      state = state.copWith(
        status: isInitial ? HomeStatus.error : HomeStatus.loadMoreError,
        errorMessage: e.toString(),
      );
    }
  }
}
