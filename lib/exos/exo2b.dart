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
  bool isSwitched = false;
  static const d = Duration(milliseconds: 50);
  Timer? timer;
  bool _isZooming = true;

  @override
  void initState() {
    super.initState();
  }

  void animate(Timer t) {
    if (!mounted) return;
    setState(() {
      _rotation = (_rotation + 0.1) % (2 * pi);
      _positionX = (_positionX + 1) % 100;

      if (_isZooming) {
        _scale += 0.01;
        if (_scale >= 2) {
          _scale = 2.0;
          _isZooming = false;
        }
      } else {
        _scale -= 0.01;
        if (_scale <= 0.5) {
          _scale = 0.5;
          _isZooming = true;
        }
      }
    });
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

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
      if (isSwitched) {
        timer = Timer.periodic(d, animate);
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
            const SizedBox(width: 120),
            const Text(" Play "),
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
            const SizedBox(width: 55),
            Switch(
                activeColor: Colors.orangeAccent,
                activeTrackColor: Colors.blue,
                inactiveThumbColor: Colors.green,
                inactiveTrackColor: Colors.red,
                value: isSwitched,
                onChanged: (value) {
                  _toggleSwitch(value);
                }),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
