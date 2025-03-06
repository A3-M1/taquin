import 'package:flutter/material.dart';
import 'exos/exolist.dart';
import 'game/gamepage.dart';
import 'game/gamelogic.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => Gamelogic()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exercices Taquin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var selectedExo = -1;

  var inGame = false;

  void selectExo(int index) {
    selectedExo = index;
    notifyListeners();
  }

  void startGame() {
    inGame = true;
    notifyListeners();
  }

  void endGame() {
    inGame = false;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var selectedExo = appState.selectedExo;
    var inGame = appState.inGame;
    Widget page;
    String title;
    bool inExercise = false;


    if (inGame) {
      page = Gamepage();
      title = "Game";
    } else if (selectedExo < 0 || selectedExo >= exerciseList.length) {
      page = ExerciceChoice();
      title = "Choose an exercise";
      inExercise = false;
    } else {
      page = exerciseList[selectedExo].page;
      title = exerciseList[selectedExo].description;
      inExercise = true;
    }

    return Scaffold(
      floatingActionButton: inExercise || inGame
        ? null
        : FloatingActionButton.extended(
            label: const Text('Play taquin'),
            tooltip: 'Play the game',
            onPressed: appState.startGame,
            icon: const Icon(Icons.videogame_asset_outlined),
          ),
      appBar: inGame ? null : AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: inExercise
            ? IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  appState.selectExo(-1);
                },
              )
            : null,
      ),
      body: page,
    );
  }
}

class ExerciceChoice extends StatelessWidget {
  const ExerciceChoice({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: exerciseList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(exerciseList[index].name),
            subtitle: Text(exerciseList[index].description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              appState.selectExo(index);
            },
          ),
        );
      },
    );
  }
}
