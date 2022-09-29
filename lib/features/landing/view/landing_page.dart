import 'package:flutter/material.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/home/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAmination(
        delay: 200,
        child: Center(
          child: Image.asset('assets/images/pokedex.png'),
        ),
      ),
    );
  }
}
