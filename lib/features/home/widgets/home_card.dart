import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/features/home/home.dart';

class HomeCard extends ConsumerWidget {
  const HomeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.onTap,
  });

  final String imageUrl;
  final String name;
  final String id;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = ref.watch(imageColorProvider(imageUrl));
    return imageProvider.maybeWhen(
      data: (paletteGenerator) => HomeCardView(
        onTap: onTap,
        id: id,
        imageUrl: imageUrl,
        name: name,
        paletteGenerator: paletteGenerator,
      ),
      orElse: () => HomeCardView(
        onTap: onTap,
        id: id,
        imageUrl: imageUrl,
        name: name,
      ),
    );
  }
}

class HomeCardView extends StatelessWidget {
  const HomeCardView({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.onTap,
    this.paletteGenerator,
  });

  final String imageUrl;
  final String name;
  final String id;
  final PaletteGenerator? paletteGenerator;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hslColor = HSLColor.fromColor(
      paletteGenerator?.dominantColor?.color ?? const Color(0xFFB8DFCA),
    );
    final backgroundAsHsl = HSLColor.fromColor(Colors.white);
    final colorDistance = math.sqrt(
      math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
          math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0),
    );
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: paletteGenerator?.dominantColor?.color ??
                    const Color(0xFFB8DFCA),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Hero(
            tag: ValueKey('__pokemon_image_${id}__'),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorDistance < 0.2
                            ? (paletteGenerator?.lightMutedColor?.color ??
                                Colors.black)
                            : (paletteGenerator?.darkMutedColor?.color ??
                                Colors.black),
                      ),
                ),
                Text(
                  '#0$id',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: paletteGenerator?.colors.last,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
