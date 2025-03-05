import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  const Exo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double imageSize = constraints.maxWidth * 0.8;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: imageSize,
                width: imageSize,
                child: Image.network(
                  'https://picsum.photos/300/300',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
