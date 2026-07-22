import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:kidquest/services/analytics_service.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() =>
      _AnalyticsScreenState();
}

class _AnalyticsScreenState
    extends State<AnalyticsScreen> {
  late Future<Map<String, dynamic>>
      analyticsFuture;

  @override
  void initState() {
    super.initState();
    analyticsFuture =
        AnalyticsService().getAnalytics();
  }

  Future<void> refresh() async {
    setState(() {
      analyticsFuture =
          AnalyticsService().getAnalytics();
    });

    await analyticsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Analytics"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: analyticsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView(
              padding:
                  const EdgeInsets.all(20),
              children: [

                Container(
                  padding:
                      const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(24),
                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(0xff4A6CF7),
                        Color(0xff6C63FF),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [

                      const Icon(
                        Icons.analytics,
                        color: Colors.white,
                        size: 70,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Family Analytics",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${(data["completionRate"] * 100).toStringAsFixed(0)}% Daily Completion",
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(),

                const SizedBox(height: 30),

                GridView.count(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.15,
                  children: [

                    _card(
                      Icons.child_care,
                      "Children",
                      "${data["children"]}",
                      Colors.blue,
                    ),

                    _card(
                      Icons.star,
                      "XP",
                      "${data["xp"]}",
                      Colors.orange,
                    ),

                    _card(
                      Icons.monetization_on,
                      "Coins",
                      "${data["coins"]}",
                      Colors.green,
                    ),

                    _card(
                      Icons.card_giftcard,
                      "Rewards",
                      "${data["rewards"]}",
                      Colors.purple,
                    ),

                    _card(
                      Icons.check_circle,
                      "Completed",
                      "${data["completedTasks"]}",
                      Colors.teal,
                    ),

                    _card(
                      Icons.pending_actions,
                      "Pending",
                      "${data["pendingTasks"]}",
                      Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Card(
                  elevation: 5,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                            20),
                    child: Column(
                      children: [

                        const ListTile(
                          leading: Icon(
                            Icons.emoji_events,
                            color:
                                Colors.amber,
                          ),
                          title: Text(
                            "Top Performer",
                          ),
                        ),

                        const Divider(),

                        Text(
                          data["topChild"],
                          style:
                              const TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Card(
                  elevation: 5,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                            20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        const Text(
                          "Completion Progress",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(
                            height: 18),

                        LinearProgressIndicator(
                          value: data[
                              "completionRate"],
                          minHeight: 14,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      20),
                        ),

                        const SizedBox(
                            height: 15),

                        Center(
                          child: Text(
                            "${(data["completionRate"] * 100).toStringAsFixed(0)}%",
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 25,
              backgroundColor:
                  color.withValues(
                alpha: 0.15,
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(title),
          ],
        ),
      ),
    ).animate().fade().scale();
  }
}