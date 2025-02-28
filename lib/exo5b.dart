import 'package:flutter/material.dart';

class Exo5b extends StatelessWidget {
  const Exo5b({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        padding: const EdgeInsets.all(10),
        children: List.generate(
          9,
          (index) => FittedBox(
            fit: BoxFit.fill,
            child: ClipRect(
              child: Align(
                //alignment: (1/3 * index%3, 1/3 * index/3),
                widthFactor: 1/3,
                heightFactor: 1/3,
                child: Image.network('https://picsum.photos/300/300'),
              ),
            ),
          ),
        ),
      ),
    );
}
}