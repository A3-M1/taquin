import 'dart:math';

import 'package:flutter/material.dart';
import 'enums.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; 
import 'dart:io';
import 'package:flutter/foundation.dart';


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
    shuffled = false;
    notifyListeners();
  }

  List<int> swapsTilesId1 = [];
  List<int> swapsTilesId2 = [];
  bool get canUndo => swapsTilesId1.isNotEmpty;
  int moveCount = 0;
  bool get gameStarted => moveCount > 0;

  Difficulty difficulty = Difficulty.easy;

  bool displayNumbers = false;

  bool shuffled = false;

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

  void shuffle(int numberOfMoves) {
    final random = Random();

    MoveDirection lastMove = MoveDirection.right;

    for (var i = 0; i < numberOfMoves; i++) {
      print('Shuffling $i');
      final emptyTile = tiles.indexWhere((element) => element == taquinResolution * taquinResolution - 1);
      final possibleMoves = <int>[];
      if (lastMove != MoveDirection.right && emptyTile % taquinResolution > 0) {
        possibleMoves.add(emptyTile - 1);
        lastMove = MoveDirection.right;
      }
      if (lastMove != MoveDirection.left && emptyTile % taquinResolution < taquinResolution - 1) {
        possibleMoves.add(emptyTile + 1);
        lastMove = MoveDirection.left;
      }
      if (lastMove != MoveDirection.down && emptyTile ~/ taquinResolution > 0) {
        possibleMoves.add(emptyTile - taquinResolution);
        lastMove = MoveDirection.down;
      }
      if (lastMove != MoveDirection.up && emptyTile ~/ taquinResolution < taquinResolution - 1) {
        possibleMoves.add(emptyTile + taquinResolution);
        lastMove = MoveDirection.up;
      }
      final move = possibleMoves[random.nextInt(possibleMoves.length)];
      swapTiles(move, emptyTile);
    }
    shuffled = true;
    notifyListeners();
  }

  bool checkWin() {
    bool win = true;
    if (gameStarted) {
      for (int i=0; i<taquinResolution*taquinResolution-1; i++) {
        if (tiles[i] != i) {
          win = false;
          break;
        }
      }
    } else {
      win = false;
    }
    return win;
  }

  bool handleTileClick(int tileId) {
    if (!shuffled) {
      shuffle((difficulty.index+1) * 20);
      return false;
    }
    final emptyTile = tiles.indexWhere((element) => element == taquinResolution*taquinResolution-1);
    
    if (emptyTile == tileId+1 || emptyTile == tileId-1 || emptyTile == tileId+taquinResolution || emptyTile == tileId-taquinResolution) {
      doMove(tileId, emptyTile);
    }

    return checkWin();
  }

  bool handleSwipe(DragEndDetails details) {
    if (!shuffled) {
      shuffle((difficulty.index+1) * 20);
      return false;
    }
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

    return checkWin();
  }



  Uint8List? webImage;
  File? image;
  String? randomImageUrl = 'https://picsum.photos/512?random=${DateTime.now().millisecondsSinceEpoch}';
  final ImagePicker picker = ImagePicker();
  final canUseCamera = !kIsWeb;

  pickImageFromGallery() async {
    if (kIsWeb) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        webImage = result.files.first.bytes;
        randomImageUrl = null;
        notifyListeners();
      }
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        randomImageUrl = null;
        notifyListeners();
      }
    }
  }

  pickImageFromCamera(BuildContext context) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera not supported on Web!")),
      );
      return;
    }

    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      randomImageUrl = null;
      notifyListeners();
    }
  }

  pickRandomImage() {
    webImage = null;
    image = null;
    randomImageUrl = 'https://picsum.photos/512?random=${DateTime.now().millisecondsSinceEpoch}';
    notifyListeners();
  }

}