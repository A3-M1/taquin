import 'package:flutter/material.dart';
import 'package:taquin/game/gamelogic.dart';
import 'taquin.dart';
import 'enums.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({Key? key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {


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

    var displayNumbers = gamelogic.displayNumbers;


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
          Taquin(taquinResolution: taquinResolution, tiles: tiles, displayNumbers: displayNumbers, image: Image.network('https://picsum.photos/512'), handleTileClick: handleTileClick, handleSwipe: handleSwipe),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return GameParameters();
                  }
                ),
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

class GameParameters extends StatefulWidget {
  const GameParameters({Key? key});

  static const titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold,);
  static var sectionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[600]);
  static const boldStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  State<GameParameters> createState() => _GameParametersState();
}

class _GameParametersState extends State<GameParameters> {

  double sliderValue = 3;

  @override
  Widget build(BuildContext context) {

    var gamelogic = context.watch<Gamelogic>();
    var appState = context.read<MyAppState>();

    var endGame = appState.endGame;

    var taquinResolution = gamelogic.taquinResolution;
    var updateTaquinResolution = gamelogic.updateTaquinResolution;

    var displayNumbers = gamelogic.displayNumbers;
    var setDisplayNumbers = gamelogic.setDisplayNumbers;

    var difficulty = gamelogic.difficulty;
    var setDifficulty = gamelogic.setDifficulty;

    var gameStarted = gamelogic.gameStarted;

    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Game parameters',
                  style: GameParameters.titleStyle,
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Help options',
                  style: GameParameters.sectionStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Display numbers',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w600),
                    ),
                  Switch(
                    value: displayNumbers,
                    onChanged: setDisplayNumbers,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Update image',
                  style: GameParameters.sectionStyle,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () {print('Pick image from gallery');},
                    label: const Text('From gallery', style: GameParameters.boldStyle,),
                    icon: Icon(Icons.photo_library_outlined),
                  ),
                  SizedBox(width: 5),
                  FilledButton.tonalIcon(
                    onPressed: () {print('Take image from camera');},
                    label: const Text('With camera', style: GameParameters.boldStyle,),
                    icon: Icon(Icons.camera_alt_outlined),
                  ),
                ]
              ),
              SizedBox(height: 5),
              FilledButton.tonalIcon(
                onPressed: () {print('Pick random image from internet');},
                label: const Text('Random from internet', style: GameParameters.boldStyle,),
                icon: Icon(Icons.shuffle_outlined),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change difficulty',
                  style: GameParameters.sectionStyle,
                ),
              ),
              SizedBox(height: 5),
              SegmentedButton<Difficulty>(
                
                segments: <ButtonSegment<Difficulty>>[
                  ButtonSegment<Difficulty>(
                    label: const Text('Easy'),
                    value: Difficulty.easy,
                    icon: const Icon(Icons.sentiment_very_satisfied_outlined),
                    enabled: !gameStarted,
                  ),
                  ButtonSegment<Difficulty>(
                    label: const Text('Medium'),
                    value: Difficulty.medium,
                    icon: const Icon(Icons.sentiment_satisfied_outlined),
                    enabled: !gameStarted,
                  ),
                  ButtonSegment<Difficulty>(
                    label: const Text('Hard'),
                    value: Difficulty.hard,
                    icon: const Icon(Icons.sentiment_dissatisfied_outlined),
                    enabled: !gameStarted,
                  ),
                ],
                onSelectionChanged: (Set<Difficulty> selection) => setDifficulty(selection.first),
                selected: <Difficulty>{difficulty},
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Size of the grid',
                  style: GameParameters.sectionStyle,
                ),
              ),
              Slider(
                value: sliderValue,
                min: 2,
                max: 10,
                divisions: 8,
                label: taquinResolution.toString(),
                onChanged: gameStarted ? null : (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                  if (value.toInt() != taquinResolution) {
                    updateTaquinResolution(value.toInt());
                  }
                },
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: () {
                    endGame();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.exit_to_app_outlined),
                  label: const Text('Exit game', style: GameParameters.boldStyle,),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}