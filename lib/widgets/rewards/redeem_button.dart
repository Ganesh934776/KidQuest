import 'package:flutter/material.dart';

class RedeemButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const RedeemButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: Icon(
          enabled ? Icons.redeem : Icons.lock,
        ),
        label: Text(
          enabled ? "Redeem Reward" : "Not Enough Coins",
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? Colors.green
              : Colors.grey.shade400,
          foregroundColor: Colors.white,
          elevation: enabled ? 6 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}