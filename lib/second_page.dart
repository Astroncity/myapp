import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  HabitPageState createState() => HabitPageState();
}

class HabitPageState extends State<SecondPage> {
  final TextEditingController _habitNameController = TextEditingController();
  final List<Habit> _habits = [];

  void _addHabit(String name) {
    setState(() {
      _habits.add(Habit(name: name));
    });
    _habitNameController.clear();
    Navigator.pop(context);
  }

  void _removeHabit(int index) {
    setState(() {
      _habits.removeAt(index);
    });
  }

  void _incrementDays(int index) {
    setState(() {
      _habits[index].days++;
    });
  }

  void _openAddHabitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a Habit"),
        content: TextField(
          controller: _habitNameController,
          decoration: const InputDecoration(hintText: "Habit Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_habitNameController.text.trim().isNotEmpty) {
                _addHabit(_habitNameController.text.trim());
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        actions: [
          const Text ("Username"),
        ],
      ),
      body: _habits.isEmpty
          ? const Center(
              child: Text(
                "No habits yet! Add one using the + button.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                final habit = _habits[index];
                return HabitCard(
                  habit: habit,
                  onRemove: () => _removeHabit(index),
                  onIncrement: () => _incrementDays(index),
                );
              },
            ),
    );
  }
}

class Habit {
  final String name;
  int days;

  Habit({required this.name, this.days = 0});
}

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onRemove,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: const Color(0xFF3c3836), // Matches Gruvbox card background
      child: ListTile(
        title: Text(
          habit.name,
          style: const TextStyle(color: Color(0xFFebdbb2)),
        ),
        subtitle: Text(
          "Days Completed: ${habit.days}",
          style: const TextStyle(color: Color(0xFF7c6f64)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: Color(0xFF83a598)),
              onPressed: onIncrement,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFfb4934)),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
