import 'package:flutter/material.dart';
import 'package:taquin/game/gamelogic.dart';
import 'taquin.dart';
import 'package:provider/provider.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({Key? key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  double sliderValue = 3;
  int taquinResolution = 3;


  @override
  Widget build(BuildContext context) {

    var gamelogic = context.watch<Gamelogic>();

    var taquinResolution = gamelogic.taquinResolution;
    var tiles = gamelogic.tiles;
    var moveCount = gamelogic.moveCount;
    var canUndo = gamelogic.canUndo;
    var gameStarted = gamelogic.gameStarted;

    var handleTileClick = gamelogic.handleTileClick;
    var handleSwipe = gamelogic.handleSwipe;
    var setupGame = gamelogic.setupGame;
    var undoMove = gamelogic.undoMove;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameStarted ? 'Move count : $moveCount' : 'Click or swipe to start',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: gameStarted ? Colors.grey[800] : Colors.grey[500]
            ),
          ),
          SizedBox(height: 10),
          Taquin(taquinResolution: taquinResolution, tiles: tiles, handleTileClick: handleTileClick, handleSwipe: handleSwipe),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => print('Game parameters'),
                tooltip: 'Game parameters',
                icon: Icon(Icons.settings_outlined),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: gameStarted ? setupGame : null,
                tooltip: 'Restart game',
                icon: Icon(Icons.autorenew_outlined),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: canUndo ? undoMove : null,
                tooltip: 'Undo move',
                icon: Icon(Icons.undo_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}