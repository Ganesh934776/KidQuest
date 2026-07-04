import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/reward.dart';
import 'package:kidquest/services/reward_service.dart';

class CreateRewardScreen extends StatefulWidget {
  const CreateRewardScreen({super.key});

  @override
  State<CreateRewardScreen> createState() =>
      _CreateRewardScreenState();
}

class _CreateRewardScreenState
    extends State<CreateRewardScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController =
      TextEditingController();
  final _coinController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _coinController.dispose();
    super.dispose();
  }

  Future<void> _saveReward() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final reward = Reward(
      parentId: FirebaseAuth.instance.currentUser!.uid,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      coinCost: int.parse(
        _coinController.text.trim(),
      ),
    );

    await RewardService().addReward(reward);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Reward created successfully!",
        ),
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration input(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reward"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.card_giftcard,
                size: 90,
                color: Colors.orange,
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Reward",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: _titleController,
                decoration: input(
                  "Reward Title",
                  Icons.emoji_events,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter reward title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller:
                    _descriptionController,
                maxLines: 3,
                decoration: input(
                  "Description",
                  Icons.description,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _coinController,
                keyboardType:
                    TextInputType.number,
                decoration: input(
                  "Coin Cost",
                  Icons.monetization_on,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter coin cost";
                  }

                  if (int.tryParse(value) ==
                      null) {
                    return "Enter a valid number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : _saveReward,
                  icon:
                      const Icon(Icons.save),
                  label: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Create Reward",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}