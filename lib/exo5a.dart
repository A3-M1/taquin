import 'package:flutter/material.dart';

class Exo5a extends StatelessWidget {
  const Exo5a({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: List.generate(
            9,
            (index) => Container(
              color: Colors.deepOrange[100 * (index+1 % 9)],
              child: Center(
                child: Text(
                  'Tile $index',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        )
    );
}
}