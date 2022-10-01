import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/home.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
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
              Image.asset(
                'assets/images/pokedex.png',
                width: 200,
              ),
              Text(
                '''Search for Pokémon by name or using the National Pokédex number.''',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 20),
              TextField(
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
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: HomeCardGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
