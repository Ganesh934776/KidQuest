import 'dart:math';
import 'dart:ui';
 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
import 'package:kidquest/screens/child/child_login_screen.dart';
import 'package:kidquest/screens/parent/parent_dashboard_screen.dart';
import 'package:kidquest/screens/parent/parent_login_screen.dart';
 
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
 
  @override
  State<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}
 
class _RoleSelectionScreenState
    extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {
      late AnimationController _pageController;
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late AnimationController _logoController;
 
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> logoScale;
  late Animation<double> backgroundAnimation;
   
  @override
  void initState() {
    super.initState();
 
    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
 
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
 
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
 
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
 
    fadeAnimation = CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeIn,
    );
 
    scaleAnimation = Tween<double>(
      begin: .75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _pageController,
        curve: Curves.elasticOut,
      ),
    );
 
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, .20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageController,
        curve: Curves.easeOutBack,
      ),
    );
 
    logoScale = Tween<double>(
      begin: .92,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );
 
    backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_backgroundController);
 
    _pageController.forward();
  }
 
  @override
  void dispose() {
    _pageController.dispose();
    _backgroundController.dispose();
    _floatingController.dispose();
    _logoController.dispose();
    super.dispose();
  }
 
  void _openParent() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentDashboardScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentLoginScreen(),
        ),
      );
    }
  }
 
  void _openChild() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChildLoginScreen(),
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
 
    return Scaffold(
      body: Stack(
        children: [
 
          // Animated Gradient Background
          AnimatedBuilder(
            animation: backgroundAnimation,
            builder: (_, __) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        const Color(0xff5B5FEF),
                        const Color(0xff00C6FF),
                        backgroundAnimation.value,
                      )!,
                      Color.lerp(
                        const Color(0xff7B61FF),
                        const Color(0xff7F7FD5),
                        backgroundAnimation.value,
                      )!,
                      Color.lerp(
                        const Color(0xff1CB5E0),
                        const Color(0xffC33764),
                        backgroundAnimation.value,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),
 
          // Floating Bubbles
          ...List.generate(
            18,
            (index) => AnimatedBuilder(
              animation: _floatingController,
              builder: (_, __) {
                return Positioned(
                  left: (index * 25.0) % size.width,
                  top: (index * 90.0) -
                      (_floatingController.value * 80),
                  child: Opacity(
                    opacity: .12,
                    child: Container(
                      width: 20 + (index % 5) * 10,
                      height: 20 + (index % 5) * 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
 
          // Floating Stars
          ...List.generate(
            25,
            (index) => Positioned(
              left: Random().nextDouble() * size.width,
              top: Random().nextDouble() * size.height,
              child: AnimatedBuilder(
                animation: _floatingController,
                builder: (_, __) {
                  return Opacity(
                    opacity: .4 + (_floatingController.value * .6),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 8 + (index % 4) * 4,
                    ),
                  );
                },
              ),
            ),
          ),
 
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: ScaleTransition(
                      scale: scaleAnimation,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(34),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 24,
                            sigmaY: 24,
                          ),
                          child: Container(
                            width: 500,
                            padding:
                                const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white.withOpacity(.12),
                              borderRadius:
                                  BorderRadius.circular(34),
                              border: Border.all(
                                color: Colors.white24,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 35,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [AnimatedBuilder(
  animation: logoScale,
  builder: (_, __) {
    return Transform.scale(
      scale: logoScale.value,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipOval(
  child: Image.asset(
    "assets/images/welcome_logo.png",
    fit: BoxFit.cover,
  ),
),
 
      ),
    );
  },
),
 
const SizedBox(height: 30),
 
                                const SizedBox(height: 25),
 
                               Text(
  "WELCOME TO",
  style: GoogleFonts.poppins(
    color: Colors.white,
    letterSpacing: 8,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
),
 
                                const SizedBox(height: 10),
 
                               ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [
      Color(0xffFFD54F),
      Color(0xff7ED957),
      Color(0xffFF69B4),
      Color(0xff7B61FF),
      Color(0xff42A5F5),
      Color(0xff26C6DA),
    ],
  ).createShader(bounds),
  child: Text(
    "KidQuest",
    style: GoogleFonts.fredoka(
      fontSize: 58,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
),
 
                                const SizedBox(height: 16),
 
                                Text(
                                  "Learn • Play • Grow Together",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 17,
                                    height: 1.6,
                                  ),
                                ),
 
                                const SizedBox(height: 35),
 
                                Row(
                                  children: [
                                    Expanded(
                                      child: _PremiumStatCard(
                                        icon: Icons.family_restroom,
                                        value: "5K+",
                                        title: "Families",
                                        color:
                                            const Color(0xff8E2DE2),
                                      ),
                                    ),
 
                                    const SizedBox(width: 14),
 
                                    Expanded(
                                      child: _PremiumStatCard(
                                        icon: Icons.task_alt,
                                        value: "12K+",
                                        title: "Tasks",
                                        color:
                                            const Color(0xff00C6FF),
                                      ),
                                    ),
 
                                    const SizedBox(width: 14),
 
                                    Expanded(
                                      child: _PremiumStatCard(
                                        icon: Icons.emoji_events,
                                        value: "98%",
                                        title: "Success",
                                        color:
                                            const Color(0xffFFB300),
                                      ),
                                    ),
                                  ],
                                ),
 
                                const SizedBox(height: 30),
 
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(28),
                                    gradient:
                                        const LinearGradient(
                                      colors: [
                                        Color(0xff7B61FF),
                                        Color(0xff5B5FEF),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.deepPurple
                                            .withOpacity(.35),
                                        blurRadius: 28,
                                        offset:
                                            const Offset(0, 14),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withOpacity(.15),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  20),
                                        ),
                                        child: const Icon(
                                          Icons.rocket_launch,
                                          color: Colors.white,
                                          size: 38,
                                        ),
                                      ),
 
                                      const SizedBox(width: 18),
 
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              "Today's Mission",
                                              style: GoogleFonts
                                                  .poppins(
                                                color:
                                                    Colors.white,
                                                fontSize: 19,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 6),
 
                                            Text(
                                              "Complete 3 fun activities and earn 50 XP.",
                                              style: GoogleFonts
                                                  .poppins(
                                                color: Colors
                                                    .white70,
                                                height: 1.5,
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 12),
 
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                          20),
                                              child:
                                                  const LinearProgressIndicator(
                                                value: .65,
                                                minHeight: 8,
                                                backgroundColor:
                                                    Colors
                                                        .white24,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  Colors.amber,
                                                ),
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 8),
 
                                            Text(
                                              "65% Completed",
                                              style: GoogleFonts
                                                  .poppins(
                                                color: Colors
                                                    .white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 32),                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Why Kids Love KidQuest",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
 
                                const SizedBox(height: 18),
 
                                Wrap(
                                  spacing: 14,
                                  runSpacing: 14,
                                  children: [
                                    _PremiumFeatureCard(
                                      icon: Icons.stars,
                                      title: "Earn XP",
                                      subtitle:
                                          "Complete tasks & level up",
                                    ),
                                    _PremiumFeatureCard(
                                      icon: Icons.card_giftcard,
                                      title: "Rewards",
                                      subtitle:
                                          "Unlock amazing gifts",
                                    ),
                                    _PremiumFeatureCard(
                                      icon: Icons.auto_graph,
                                      title: "Progress",
                                      subtitle:
                                          "Track daily growth",
                                    ),
                                    _PremiumFeatureCard(
                                      icon: Icons.groups,
                                      title: "Family Fun",
                                      subtitle:
                                          "Parents & Kids together",
                                    ),
                                  ],
                                ),
 
                                const SizedBox(height: 36),
 
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Achievements",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
 
                                const SizedBox(height: 18),
 
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _AchievementCard(
                                        icon: Icons.emoji_events,
                                        title: "Gold Trophy",
                                        subtitle: "100 Tasks",
                                        color: const Color(0xffFFD54F),
                                      ),
 
                                      const SizedBox(width: 16),
 
                                      _AchievementCard(
                                        icon:
                                            Icons.workspace_premium,
                                        title: "Level 10",
                                        subtitle: "XP Master",
                                        color: const Color(0xff7B61FF),
                                      ),
 
                                      const SizedBox(width: 16),
 
                                      _AchievementCard(
                                        icon: Icons.military_tech,
                                        title: "Champion",
                                        subtitle: "Top Kid",
                                        color: const Color(0xff00C6FF),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 34),
 
 
 
   Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Popular Rewards",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
 
                                const SizedBox(height: 18),
 
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withOpacity(.10),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  22),
                                          border: Border.all(
                                            color: Colors.white24,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.toys,
                                              size: 50,
                                              color: Colors.orange,
                                            ),
 
                                            const SizedBox(
                                                height: 12),
 
                                            Text(
                                              "Toy Car",
                                              style: GoogleFonts
                                                  .poppins(
                                                color:
                                                    Colors.white,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 6),
 
                                            Text(
                                              "500 XP",
                                              style: GoogleFonts
                                                  .poppins(
                                                color: Colors
                                                    .white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
 
                                    const SizedBox(width: 16),
 
                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withOpacity(.10),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  22),
                                          border: Border.all(
                                            color: Colors.white24,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons
                                                  .sports_esports,
                                              size: 50,
                                              color:
                                                  Colors.lightGreen,
                                            ),
 
                                            const SizedBox(
                                                height: 12),
 
                                            Text(
                                              "Game Time",
                                              style: GoogleFonts
                                                  .poppins(
                                                color:
                                                    Colors.white,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 6),
 
                                            Text(
                                              "300 XP",
                                              style: GoogleFonts
                                                  .poppins(
                                                color: Colors
                                                    .white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
 
                                const SizedBox(height: 34),
 
                                Container(
                                  padding:
                                      const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white.withOpacity(.10),
                                    borderRadius:
                                        BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lightbulb,
                                        color: Colors.amber,
                                        size: 42,
                                      ),
 
                                      const SizedBox(width: 18),
 
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              "Parent Tip",
                                              style: GoogleFonts
                                                  .poppins(
                                                color:
                                                    Colors.white,
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
 
                                            const SizedBox(
                                                height: 6),
 
                                            Text(
                                              "Encourage children by giving rewards for every completed daily mission.",
                                              style: GoogleFonts
                                                  .poppins(
                                                color: Colors
                                                    .white70,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 40),                                SizedBox(
                                  width: double.infinity,
                                  height: 90,
                                  child: _PremiumRoleButton(
                                    icon: Icons.family_restroom_rounded,
                                    title: "Parent Dashboard",
                                    subtitle:
                                        "Manage routines, rewards & children",
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff6A5AE0),
                                        Color(0xff8E2DE2),
                                      ],
                                    ),
                                    onTap: _openParent,
                                  ),
                                ),
 
                                const SizedBox(height: 18),
 
                                SizedBox(
                                  width: double.infinity,
                                  height: 90,
                                  child: _PremiumOutlineButton(
                                    icon: Icons.rocket_launch_rounded,
                                    title: "Child Adventure",
                                    subtitle:
                                        "Play • Learn • Earn Rewards",
                                    onTap: _openChild,
                                  ),
                                ),
 
                                const SizedBox(height: 35),
 
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.08),
                                    borderRadius:
                                        BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                        size: 42,
                                      ),
 
                                      const SizedBox(height: 12),
 
                                      Text(
                                        "Every small habit builds a brighter future 🌟",
                                        textAlign: TextAlign.center,
                                        style:
                                            GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight:
                                              FontWeight.w600,
                                          fontSize: 17,
                                          height: 1.5,
                                        ),
                                      ),
 
                                      const SizedBox(height: 10),
 
                                      Text(
                                        "Make learning fun every single day with KidQuest.",
                                        textAlign:
                                            TextAlign.center,
                                        style:
                                            GoogleFonts.poppins(
                                          color:
                                              Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 30),
 
                                Divider(
                                  color:
                                      Colors.white.withOpacity(.20),
                                ),
 
                                const SizedBox(height: 18),
 
                                Text(
                                  "Made with ❤️ for Parents & Kids",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
 
                                const SizedBox(height: 8),
 
                                Text(
                                  "KidQuest Premium • Version 2.0",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
 
                                const SizedBox(height: 12),
 
                                Text(
                                  "© 2026 KidQuest",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
    }
  class _PremiumStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;
  final Color color;
 
  const _PremiumStatCard({
    required this.icon,
    required this.value,
    required this.title,
    required this.color,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        children: [
 
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(.20),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
 
          const SizedBox(height: 14),
 
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
 
          const SizedBox(height: 6),
 
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
 
class _PremiumFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
 
  const _PremiumFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
 
          CircleAvatar(
            radius: 24,
            backgroundColor:
                Colors.white.withOpacity(.15),
            child: Icon(
              icon,
              color: Colors.amber,
            ),
          ),
 
          const SizedBox(height: 16),
 
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
 
          const SizedBox(height: 6),
 
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
 
  const _AchievementCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(.20),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
 
          const SizedBox(height: 14),
 
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
 
          const SizedBox(height: 6),
 
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
 
class _PremiumRoleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;
 
  const _PremiumRoleButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(.35),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
 
                const SizedBox(width: 18),
 
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
 
                      const SizedBox(height: 4),
 
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
 
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _PremiumOutlineButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
 
  const _PremiumOutlineButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white24,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withOpacity(.12),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
 
                const SizedBox(width: 18),
 
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
 
                      const SizedBox(height: 4),
 
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
 
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
 