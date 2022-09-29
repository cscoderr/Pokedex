import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
  });

  final String imageUrl;
  final String name;
  final String id;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  PaletteGenerator? _palletGenerator;

  @override
  void initState() {
    super.initState();
    _getImageColors();
  }

  Future<void> _getImageColors() async {
    _palletGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(
        widget.imageUrl,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hslColor = HSLColor.fromColor(
      _palletGenerator?.dominantColor?.color ?? const Color(0xFFB8DFCA),
    );
    final backgroundAsHsl = HSLColor.fromColor(Colors.white);
    final colorDistance = math.sqrt(
      math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
          math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0),
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _palletGenerator?.dominantColor?.color ??
                  const Color(0xFFB8DFCA),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Image.network(
          widget.imageUrl,
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                widget.name,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorDistance < 0.2
                          ? (_palletGenerator?.lightMutedColor?.color ??
                              Colors.black)
                          : (_palletGenerator?.darkMutedColor?.color ??
                              Colors.black),
                    ),
              ),
              Text(
                '#0${widget.id}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: _palletGenerator?.colors.last ?? Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
