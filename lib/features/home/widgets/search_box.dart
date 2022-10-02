import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/home.dart';

class SearchBox extends ConsumerWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);
    return TextField(
      onChanged: (value) => ref.read(homeProvider.notifier).search(value),
      decoration: InputDecoration(
        fillColor: const Color(0xFFE6F0F3),
        filled: true,
        hintText: 'What Pokémon are you looking for?',
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.grey,
            ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
          size: 30,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
