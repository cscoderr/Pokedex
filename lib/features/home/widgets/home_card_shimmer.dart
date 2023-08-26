import 'package:flutter/material.dart';
import 'package:pokedex/core/core.dart';
import 'package:shimmer/shimmer.dart';

class HomeCardShimmer extends StatelessWidget {
  const HomeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ScreenSize.crossAxisCount(context),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.6,
        ),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
