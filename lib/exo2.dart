import 'package:flutter/material.dart';
import 'dart:math';

class Exo2 extends StatefulWidget {
  const Exo2({super.key});

  @override
  State<Exo2> createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  double _rotation = 0;
  double _scale = 1;
  bool _isMirrored = false;
  double _positionX = 0;

  void _resetTransformations() {
    setState(() {
      _rotation = 0;
      _scale = 1;
      _isMirrored = false;
      _positionX = 0;
    });
  }

  void _rotateBy(double angle) {
    setState(() {
      _rotation =
          (_rotation + angle) % (2 * pi); // Garde la rotation entre 0 et 2π
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width * 0.9;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(_positionX, 0)
                ..rotateZ(_rotation)
                ..scale(_isMirrored ? -_scale : _scale, _scale),
              child: Image.network(
                'https://picsum.photos/300/300',
                width: screenSize, // Taille dynamique
                height: screenSize, // Garde un format carré
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Text("Rotation"),
        Slider(
          value: _rotation,
          min: 0,
          max: 2 * pi,
          onChanged: (value) {
            setState(() {
              _rotation = value;
            });
          },
        ),
        const Text("Zoom"),
        Slider(
          value: _scale,
          min: 0.5,
          max: 2.0,
          onChanged: (value) {
            setState(() {
              _scale = value;
            });
          },
        ),
        const Text("Déplacement Horizontal"),
        Slider(
          value: _positionX,
          min: -100,
          max: 100,
          onChanged: (value) {
            setState(() {
              _positionX = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _rotateBy(-pi / 2),
              icon: const Icon(Icons.rotate_left),
            ),
            IconButton(
              onPressed: () => _rotateBy(pi / 2),
              icon: const Icon(Icons.rotate_right),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isMirrored = !_isMirrored;
                });
              },
              child: const Text("Effet Miroir"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _resetTransformations,
              child: const Text("Reset"),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
