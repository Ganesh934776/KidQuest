import 'package:flutter/material.dart';

class MyWorldScreen extends StatelessWidget {
  const MyWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌍 My World"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6EC6FF),
              Color(0xffEAF8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 170,
                  color: Colors.green,
                ),
              ),
            ),

            const Positioned(
              top: 40,
              left: 50,
              child: Text(
                "☀️",
                style: TextStyle(fontSize: 60),
              ),
            ),

            const Positioned(
              bottom: 90,
              left: 40,
              child: Text(
                "🌳",
                style: TextStyle(fontSize: 45),
              ),
            ),

            const Positioned(
              bottom: 80,
              left: 150,
              child: Text(
                "🌸",
                style: TextStyle(fontSize: 38),
              ),
            ),

            const Positioned(
              bottom: 100,
              right: 50,
              child: Text(
                "🏡",
                style: TextStyle(fontSize: 50),
              ),
            ),

            const Positioned(
              bottom: 180,
              right: 120,
              child: Text(
                "🦋",
                style: TextStyle(fontSize: 36),
              ),
            ),

            const Center(
              child: Text(
                "Your world grows\nwhen you complete tasks!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}