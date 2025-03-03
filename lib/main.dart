import 'package:flutter/material.dart';
import 'exolist.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
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

  void selectExo(int index) {
    selectedExo = index;
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
    Widget page;
    String title;
    bool inExercise = false;

    if (selectedExo < 0 || selectedExo >= exerciseList.length) {
      page = ExerciceChoice();
      title = "Choose an exercise";
      inExercise = false;
    } else {
      page = exerciseList[selectedExo].page;
      title = exerciseList[selectedExo].description;
      inExercise = true;
    }

    return Scaffold(
      appBar: AppBar(
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

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
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
      ),
    );
  }
}
