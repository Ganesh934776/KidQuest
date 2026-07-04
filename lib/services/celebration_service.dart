import 'package:flutter/material.dart';

class CelebrationService {
  static Future<void> showSuccess({
    required BuildContext context,
    required String message,
    IconData icon = Icons.check_circle,
    Color color = Colors.green,
  }) async {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}