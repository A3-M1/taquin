import 'package:flutter/material.dart';
import 'enums.dart';


class Gamelogic extends ChangeNotifier {

  static const int sensitivity = 6;
  
  int taquinResolution = 3;
  List<int> tiles = List.generate(9, (index) => index);

  void updateTaquinResolution(int value) {
    taquinResolution = value;
    notifyListeners();
    setupGame();
  }

  void setupGame() {
    tiles = List.generate(taquinResolution*taquinResolution, (index) => index);
    swapsTilesId1.clear();
    swapsTilesId2.clear();
    moveCount = 0;
    notifyListeners();
  }

  List<int> swapsTilesId1 = [];
  List<int> swapsTilesId2 = [];
  bool get canUndo => swapsTilesId1.isNotEmpty;
  int moveCount = 0;
  bool get gameStarted => moveCount > 0;

  Difficulty difficulty = Difficulty.easy;

  bool displayNumbers = false;

  void setDifficulty(Difficulty value) {
    difficulty = value;
    notifyListeners();
  }

  void setDisplayNumbers(bool value) {
    displayNumbers = value;
    notifyListeners();
  }

  void swapTiles(int tileId1, int tileId2) {
    final temp = tiles[tileId1];
    tiles[tileId1] = tiles[tileId2];
    tiles[tileId2] = temp;
    notifyListeners();
  }

  void doMove(int tileId1, int tileId2) {
    if (swapsTilesId1.isEmpty || !(swapsTilesId1.last == tileId2 && swapsTilesId2.last == tileId1)) {
      swapsTilesId1.add(tileId1);
      swapsTilesId2.add(tileId2);
      moveCount += 1;
    } else {
      swapsTilesId1.removeLast();
      swapsTilesId2.removeLast();
      moveCount -= 1;
    }
    swapTiles(tileId1, tileId2);
  }

  void undoMove() {
    if (canUndo) {
      swapTiles(swapsTilesId1.removeLast(), swapsTilesId2.removeLast());
      moveCount -= 1;
    }
  }

  void handleTileClick(int tileId) {
    final emptyTile = tiles.indexWhere((element) => element == taquinResolution*taquinResolution-1);
    
    if (emptyTile == tileId+1 || emptyTile == tileId-1 || emptyTile == tileId+taquinResolution || emptyTile == tileId-taquinResolution) {
      doMove(tileId, emptyTile);
    }
  }

  void handleSwipe(DragEndDetails details) {
    final int emptyTileId = tiles.indexWhere((element) => element == taquinResolution * taquinResolution - 1);
    final int emptyTileColumn = emptyTileId % taquinResolution;
    final int emptyTileRow = (emptyTileId / taquinResolution).toInt();

    if (details.velocity.pixelsPerSecond.dx.abs() > details.velocity.pixelsPerSecond.dy.abs()) {
      if (details.velocity.pixelsPerSecond.dx > sensitivity && emptyTileColumn > 0) {
        doMove(emptyTileId, emptyTileId - 1);
      } else if (details.velocity.pixelsPerSecond.dx < -sensitivity && emptyTileColumn < taquinResolution - 1) {
        doMove(emptyTileId, emptyTileId + 1);
      }
    } else {
      if (details.velocity.pixelsPerSecond.dy > sensitivity && emptyTileRow > 0) {
        doMove(emptyTileId, emptyTileId - taquinResolution);
      } else if (details.velocity.pixelsPerSecond.dy < -sensitivity && emptyTileRow < taquinResolution - 1) {
        doMove(emptyTileId, emptyTileId + taquinResolution);
      }
    }
  }

}