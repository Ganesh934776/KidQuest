import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final DateTime deadline;

  const CountdownTimerWidget({
    super.key,
    required this.deadline,
  });

  @override
  State<CountdownTimerWidget> createState() =>
      _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState
    extends State<CountdownTimerWidget> {
  late Timer timer;

  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    _update();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _update(),
    );
  }

  void _update() {
    final diff =
        widget.deadline.difference(DateTime.now());

    if (!mounted) return;

    setState(() {
      remaining =
          diff.isNegative ? Duration.zero : diff;
    });
  }

  String format(Duration d) {
    String two(int n) =>
        n.toString().padLeft(2, '0');

    return
        "${two(d.inHours)}:"
        "${two(d.inMinutes.remainder(60))}:"
        "${two(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    if (remaining == Duration.zero) {
      return const Row(
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          SizedBox(width: 6),
          Text(
            "Time Over",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Icon(
          Icons.timer,
          color: Colors.deepOrange,
        ),
        const SizedBox(width: 6),
        Text(
          format(remaining),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}