import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/home.dart';

class LoadMoreWidget extends ConsumerWidget {
  const LoadMoreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeProvider);
          if (state.status == HomeStatus.loadMoreError) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.info,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'An error occured, Try again',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          } else if (state.status == HomeStatus.loadMore) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
