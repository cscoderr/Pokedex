import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final images = [
      'assets/images/001.png',
      'assets/images/003.png',
      'assets/images/006.png'
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pokédex',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
              ),
              Text(
                '''Search for Pokémon by name or using the National Pokédex number.''',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xFFE6F0F3),
                        filled: true,
                        hintText: 'What Pokémon are you looking for?',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A4C6B),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_accessibility_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: homeState.when(
                  data: (data) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: data.results?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final pokemon = data.results![index];
                      return HomeCard(
                        id: pokemon.id,
                        imageUrl: pokemon.getImageUrl,
                        name: pokemon.name!,
                      );
                    },
                  ),
                  error: (error, __) => Text(error.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
