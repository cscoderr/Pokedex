import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          HomeSilverAppBar(scrollController: scrollController),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            sliver: HomeCardGridView(),
          ),
        ],
      ),
    );
  }
}

class HomeSilverAppBar extends StatefulWidget {
  const HomeSilverAppBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<HomeSilverAppBar> createState() => _HomeSilverAppBarState();
}

class _HomeSilverAppBarState extends State<HomeSilverAppBar> {
  double _titleOpacity = 0;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(scrollControllerListener);
  }

  void scrollControllerListener() {
    final pixel = widget.scrollController.position.pixels;

    if (pixel > (210 - 70)) {
      _titleOpacity = 1;
      setState(() {});
    } else {
      _titleOpacity = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 210,
      collapsedHeight: 70,
      title: AnimatedOpacity(
        opacity: _titleOpacity,
        duration: const Duration(milliseconds: 500),
        child: TextField(
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
      ),
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            SizedBox(
              width: 200,
              child: Hero(
                tag: const ValueKey('__pokedex__'),
                child: Image.asset(
                  'assets/images/pokedex.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                '''Search for Pokémon by name or using the National Pokédex number.''',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
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
            ),
          ],
        ),
      ),
    );
  }
}
