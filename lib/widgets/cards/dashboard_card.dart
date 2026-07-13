import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: AppColors.cardShadow,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(AppSpacing.cardRadius),
        onTap: onTap,
        child: Padding(
          padding: padding ??
              const EdgeInsets.all(AppSpacing.md),
          child: child,
        ),
      ),
    );
  }
}