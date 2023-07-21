import 'dart:math';

void main() {
  print('start');
  const potential = 25;
  var population = <double>[0.7, 0.8, 0.9, 0.9, 1, 1, 1, 1, 1.1, 1.1, 1.2, 1.2];
  for (var i = 1; i <= 1000; i++) {
    final offsprings = <double>[];
    while (population.length >= 2) {
      final last = population.removeLast();
      int randomIndex;
      if (population.length > 10) {
        // sexual selection
        randomIndex =
            population.length - Random().nextInt(population.length ~/ 10) - 1;
      } else {
        randomIndex = population.length - 1;
      }
      final random = population.removeAt(randomIndex);
      final value = (last * random) / (last + random) * 2;

      // fertility
      final number = value * potential.toInt();
      for (var count = 0; count <= number; count++) {
        final luck = Random().nextDouble();
        var offspring = value;
        // mutation - 60% chance of bad mutation
        if (luck > 0.99) {
          offspring += 0.001;
        } else if (luck > 0.6) {
          // no mutation
        } else if (luck > 0.5) {
          offspring -= 0.025;
        } else if (luck > 0.4) {
          offspring -= 0.05;
        } else if (luck > 0.3) {
          offspring -= 0.1;
        } else if (luck > 0.2) {
          offspring -= 0.2;
        } else if (luck > 0.1) {
          offspring -= 0.4;
        } else {
          offspring = 0.8;
        }

        // survivability - hash environment and competition
        double competition =
            offsprings.length / 1000 + population.length / 10000;

        if (offspring > Random().nextDouble() * (2 + competition)) {
          offsprings.add(offspring);
        }
      }
    }
    offsprings.sort();
    population = offsprings;
    if (population.isEmpty) {
      print('Roun $i: end');
      break;
    } else {
      print(
          'Round $i: offsprings ${population.length}, 25% ${population[population.length ~/ 4]}, median ${population[population.length ~/ 2]}, top 1/8 ${population[population.length ~/ 8 * 7]} max ${population.last}');
    }
  }
}
