import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Exo2b extends StatefulWidget {
  const Exo2b({super.key});

  @override
  State<Exo2b> createState() => _Exo2bState();
}

class _Exo2bState extends State<Exo2b> {
  double _rotation = 0;
  double _scale = 1;
  bool _isMirrored = false;
  double _positionX = 0;

  @override
  void initState() {
    super.initState();
    const d = Duration(milliseconds: 50);
    Timer.periodic(d, animate);
  }

  void animate(Timer t) {
    t.cancel();
  }

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
      _rotation = (_rotation + angle) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double containerWidth = constraints.maxWidth * 0.8;
              double containerHeigth = constraints.maxHeight * 0.8;

              return Container(
                width: containerWidth,
                height: containerHeigth,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(_positionX, 0)
                        ..rotateZ(_rotation)
                        ..scale(_isMirrored ? -_scale : _scale, _scale),
                      child: Image.network(
                        'https://picsum.photos/512/1024',
                        fit: BoxFit.cover,
                        width: containerWidth,
                        height: containerHeigth,
                      ),
                    ),
                  ),
                ),
              );
            },
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
