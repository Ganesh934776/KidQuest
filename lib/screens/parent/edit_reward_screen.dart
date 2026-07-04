import 'package:flutter/material.dart';
import 'package:kidquest/models/reward.dart';
import 'package:kidquest/services/reward_service.dart';

class EditRewardScreen extends StatefulWidget {
  final Reward reward;

  const EditRewardScreen({
    super.key,
    required this.reward,
  });

  @override
  State<EditRewardScreen> createState() =>
      _EditRewardScreenState();
}

class _EditRewardScreenState
    extends State<EditRewardScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _coinController;

  final RewardService _rewardService = RewardService();

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.reward.title);

    _descriptionController =
        TextEditingController(
      text: widget.reward.description,
    );

    _coinController = TextEditingController(
      text: widget.reward.coinCost.toString(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _coinController.dispose();
    super.dispose();
  }

  Future<void> _saveReward() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedReward = Reward(
      id: widget.reward.id,
      parentId: widget.reward.parentId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      coinCost: int.parse(_coinController.text),
      isAvailable: widget.reward.isAvailable,
    );

    await _rewardService.updateReward(updatedReward);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Reward updated successfully!",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Reward"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Reward Title",
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Please enter reward title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _coinController,
                keyboardType:
                    TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Coin Cost",
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter Coin Cost";
                  }

                  if (int.tryParse(value) ==
                      null) {
                    return "Enter a valid number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveReward,
                  child: const Text(
                    "Save Changes",
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