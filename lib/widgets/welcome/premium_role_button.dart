import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumRoleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const PremiumRoleButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 130,
        borderRadius: 24,
        blur: 18,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            color.withValues(alpha: .30),
            Colors.white.withValues(alpha: .12),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white,
            color,
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [

              CircleAvatar(
                radius: 32,
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style:
                          GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style:
                          GoogleFonts.poppins(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}