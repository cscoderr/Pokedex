import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

final imageColorProvider =
    FutureProvider.family<PaletteGenerator, String>((ref, imageUrl) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(
      imageUrl,
    ),
  );
  return paletteGenerator;
});
