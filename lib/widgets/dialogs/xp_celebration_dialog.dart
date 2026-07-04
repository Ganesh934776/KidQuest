import 'package:flutter/material.dart';
import 'package:kidquest/widgets/animations/xp_celebration_card.dart';

class XPCelebrationDialog {
  static Future<void> show(
    BuildContext context, {
    required int xp,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: XPCelebrationCard(
              xp: xp,
            ),
          ),
        );
      },
    );
  }
}