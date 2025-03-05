import 'package:flutter/material.dart';

class Exo5c extends StatefulWidget {
  const Exo5c({super.key});

  @override
  State<Exo5c> createState() => _Exo5cState();
}

class _Exo5cState extends State<Exo5c> {

  double sliderValue = 3;
  int taquinResolution = 3;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: taquinResolution,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              padding: const EdgeInsets.all(10),
              children: List.generate(
                taquinResolution*taquinResolution,
                (index) => FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment(
                        (index%taquinResolution)*2/(taquinResolution-1)-1,
                        (index/taquinResolution).toInt()*2/(taquinResolution-1)-1
                      ),
                      widthFactor: 1/taquinResolution,
                      heightFactor: 1/taquinResolution,
                      child: Image.network('https://picsum.photos/512'),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 20),
          Slider(
            value: sliderValue,
            min: 2,
            max: 10,
            divisions: 8,
            label: taquinResolution.toString(),
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
                taquinResolution = value.toInt();
              });
            },
          ),
        ],
      ),
    );
}
}