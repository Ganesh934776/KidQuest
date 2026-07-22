

import '../models/adventure.dart';

class AdventureService {
  static final List<Adventure> adventures = [
    Adventure(
      title: "Morning Hero",
      description: "Complete all morning tasks.",
      rewardXP: 100,
      rewardCoins: 40,
    ),
    Adventure(
      title: "Homework Master",
      description: "Finish your homework today.",
      rewardXP: 120,
      rewardCoins: 50,
    ),
    Adventure(
      title: "Healthy Champion",
      description: "Eat healthy food today.",
      rewardXP: 80,
      rewardCoins: 30,
    ),
    Adventure(
      title: "Super Explorer",
      description: "Complete every daily task.",
      rewardXP: 200,
      rewardCoins: 100,
    ),
  ];

  static Adventure getTodayAdventure() {
    final day = DateTime.now().day;
    return adventures[day % adventures.length];
  }
}