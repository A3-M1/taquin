import 'package:flutter/material.dart';

class Exo6b extends StatefulWidget {
  const Exo6b({super.key});

  @override
  State<Exo6b> createState() => _Exo6bState();
}

class _Exo6bState extends State<Exo6b> {

  double sliderValue = 3;
  int taquinResolution = 3;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Taquin(taquinResolution: taquinResolution),
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


class Taquin extends StatefulWidget {

  final int taquinResolution;

  const Taquin({
    super.key,
    required this.taquinResolution
  });

  @override
  State<Taquin> createState() => _TaquinState();
}

class _TaquinState extends State<Taquin> {

  late int taquinResolution;
  late List<int> tiles;
  static const int sensitivity = 6;

  @override
  void initState() {
    super.initState();
    taquinResolution = widget.taquinResolution;
    tiles = List.generate(taquinResolution*taquinResolution, (index) => index);
  }

  @override
  void didUpdateWidget(covariant Taquin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.taquinResolution != widget.taquinResolution) {
      taquinResolution = widget.taquinResolution;
      tiles = List.generate(taquinResolution*taquinResolution, (index) => index);
    }
  }

  void swapTiles(int tile1, int tile2) {
    setState(() {
      final temp = tiles[tile1];
      tiles[tile1] = tiles[tile2];
      tiles[tile2] = temp;
    });
  }

  void handleTileClick(int tileNumber) {
    final emptyTile = tiles.indexWhere((element) => element == taquinResolution*taquinResolution-1);
    
    if (emptyTile == tileNumber+1 || emptyTile == tileNumber-1 || emptyTile == tileNumber+taquinResolution || emptyTile == tileNumber-taquinResolution) {
      swapTiles(tileNumber, emptyTile);
    }
  }

  void handleSwipe(DragEndDetails details) {
    final int emptyTile = tiles.indexWhere((element) => element == taquinResolution * taquinResolution - 1);
    final int emptyTileColumn = emptyTile % taquinResolution;
    final int emptyTileRow = (emptyTile / taquinResolution).toInt();

    if (details.velocity.pixelsPerSecond.dx.abs() > details.velocity.pixelsPerSecond.dy.abs()) {
      if (details.velocity.pixelsPerSecond.dx > sensitivity && emptyTileColumn > 0) {
        swapTiles(emptyTile, emptyTile - 1);
      } else if (details.velocity.pixelsPerSecond.dx < -sensitivity && emptyTileColumn < taquinResolution - 1) {
        swapTiles(emptyTile, emptyTile + 1);
      }
    } else {
      if (details.velocity.pixelsPerSecond.dy > sensitivity && emptyTileRow > 0) {
        swapTiles(emptyTile, emptyTile - taquinResolution);
      } else if (details.velocity.pixelsPerSecond.dy < -sensitivity && emptyTileRow < taquinResolution - 1) {
        swapTiles(emptyTile, emptyTile + taquinResolution);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) => handleSwipe(details),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: taquinResolution,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          taquinResolution*taquinResolution,
          (index) => Tile(
            tileNumber: tiles[index], 
            taquinResolution: taquinResolution, 
            imageUrl: 'https://picsum.photos/512',
            onTap: () => handleTileClick(index),
            displayNumber: true,
          ),
        ),
      ),
    );
  }
}


class Tile extends StatelessWidget {

  Tile({
    super.key,
    required this.tileNumber,
    required this.taquinResolution,
    required this.imageUrl,
    required this.onTap,
    this.displayNumber = false
  });

  // The tile number is the index of the tile in the grid of the original image (not after being mixed). The number corresponds to latin reading order.
  final int tileNumber;
  final int taquinResolution;
  final String imageUrl;
  final void Function() onTap;
  final bool displayNumber;


  @override
  Widget build(BuildContext context) {

    final bool emptyTile = taquinResolution*taquinResolution-1 == tileNumber;

    if (emptyTile) {
      return Container();
    }

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          FittedBox(
            fit: BoxFit.fill,
            child: ClipRect(
              child: Align(
                alignment: Alignment(
                  (tileNumber%taquinResolution)*2/(taquinResolution-1)-1,
                  (tileNumber/taquinResolution).toInt()*2/(taquinResolution-1)-1
                ),
                widthFactor: 1/taquinResolution,
                heightFactor: 1/taquinResolution,
                child: Image.network(imageUrl),
              ),
            ),
          ),
          if (displayNumber) Center(
            child: Text(
              (tileNumber+1).toString(),
              style: TextStyle(
                color: Colors.white.withAlpha(200),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ]
      ),
    );
  }

}