class World {
  final int trees;
  final int flowers;
  final int butterflies;
  final int houses;
  final int dragons;
  final int treasure;
  final int clouds;

  const World({
    required this.trees,
    required this.flowers,
    required this.butterflies,
    required this.houses,
    required this.dragons,
    required this.treasure,
    required this.clouds,
  });

  factory World.fromProgress({
    required int completedTasks,
    required int streak,
    required int level,
  }) {
    return World(
      trees: completedTasks ~/ 2,
      flowers: streak,
      butterflies: streak >= 7 ? 4 : streak ~/ 2,
      houses: level ~/ 5,
      dragons: level >= 20 ? 1 : 0,
      treasure: completedTasks >= 9 ? 1 : 0,
      clouds: 4,
    );
  }
}