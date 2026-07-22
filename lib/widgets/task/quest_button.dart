import 'package:flutter/material.dart';

class QuestButton extends StatelessWidget {
  final bool completed;
  final bool expired;
  final bool loading;
  final Future<void> Function() onPressed;
  final Color color;

  const QuestButton({
    super.key,
    required this.completed,
    required this.expired,
    required this.loading,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: completed || expired || loading
            ? null
            : onPressed,

        icon: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(
                completed
                    ? Icons.emoji_events
                    : Icons.rocket_launch,
              ),

        label: Text(
          completed
              ? "Quest Complete"
              : expired
                  ? "Quest Closed"
                  : "Begin Quest",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: completed
              ? Colors.green
              : expired
                  ? Colors.grey
                  : color,

          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}