import 'exo0.dart';
import 'exo1.dart';
import 'exo2b.dart';
import 'exo.dart';
import 'exo2.dart';
import 'exo4.dart';
import 'exo5a.dart';
import 'exo5b.dart';
import 'exo5c.dart';

final exerciseList = [
  Exercice(
      name: 'Exercice 0',
      description: 'Collect image from the phone or camera',
      page: Exo0()),
  Exercice(name: 'Exercice 1', description: 'Display image', page: Exo1()),
  Exercice(
      name: 'Exercice 2', description: 'Rotate & Scale Image', page: Exo2()),
  Exercice(
      name: 'Exercice 2b',
      description: ' Animated Rotate & Scale Image',
      page: Exo2b()),
  Exercice(
      name: 'Exercice 4', description: 'ClipRect & FittedBox', page: Exo4()),
  Exercice(name: 'Exercice 5a', description: 'Display a grid', page: Exo5a()),
  Exercice(
      name: 'Exercice 5b', description: 'Display an image grid', page: Exo5b()),
  Exercice(
      name: 'Exercice 5c',
      description: 'Display an adaptative image grid',
      page: Exo5c()),
];
