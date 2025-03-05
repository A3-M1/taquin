import 'package:flutter/material.dart';
import 'taquin.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({Key? key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  double sliderValue = 3;
  int taquinResolution = 3;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Taquin(taquinResolution: taquinResolution),
        ],
      ),
    );
  }
}