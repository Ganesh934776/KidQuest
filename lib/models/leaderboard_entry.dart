import 'package:kidquest/models/child.dart';

class LeaderboardEntry {
  final Child child;
  final int rank;

  const LeaderboardEntry({
    required this.child,
    required this.rank,
  });
}