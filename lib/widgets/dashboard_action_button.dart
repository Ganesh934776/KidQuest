import 'package:flutter/material.dart';

class DashboardActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool outlined;

  const DashboardActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}