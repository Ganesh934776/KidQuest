import 'package:flutter/material.dart';
import 'package:kidquest/models/pet.dart';
import 'package:kidquest/widgets/pet/pet_card.dart';

class PetScreen extends StatelessWidget {

  final int xp;

  const PetScreen({
    super.key,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {

    final pet = Pet.fromXP(xp);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Dragon"),
      ),
      body: SingleChildScrollView(
        child: PetCard(
          pet: pet,
        ),
      ),
    );
  }
}