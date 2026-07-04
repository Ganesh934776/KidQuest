import 'package:confetti/confetti.dart';

class CelebrationHelper {
  static ConfettiController createController() {
    return ConfettiController(
      duration: const Duration(
        seconds: 2,
      ),
    );
  }
}