import 'package:flutter/material.dart';

class PokdexLoader extends StatelessWidget {
  const PokdexLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 30,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
