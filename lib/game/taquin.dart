import 'package:flutter/material.dart';


class Taquin extends StatelessWidget {

  final int taquinResolution;
  final List<int> tiles;
  final bool displayNumbers;
  final Function(int) handleTileClick;
  final Function(DragEndDetails) handleSwipe;

  const Taquin({
    super.key,
    required this.taquinResolution,
    required this.tiles,
    required this.displayNumbers,
    required this.handleTileClick,
    required this.handleSwipe,
  });

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
            displayNumber: displayNumbers,
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