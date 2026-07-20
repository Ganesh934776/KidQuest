import 'package:flutter/material.dart';

class PremiumSectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const PremiumSectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        if (action != null)
          InkWell(
            onTap: onTap,
            child: Text(
              action!,
              style: TextStyle(
                color: Colors.deepPurple.shade400,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}