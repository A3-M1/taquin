import 'package:flutter/material.dart';

class Exo4 extends StatelessWidget {
  const Exo4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: FittedBox(
              fit: BoxFit.fill,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topRight,
                  widthFactor: 0.3,
                  heightFactor: 0.3,
                  child: Image.network('https://picsum.photos/300/300'),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Image.network('https://picsum.photos/300/300'),       
        ],
      ),
    );
}
}