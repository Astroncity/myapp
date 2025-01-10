import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  HabitPageState createState() => HabitPageState();
}

class HabitPageState extends State<SecondPage> {
  final TextEditingController _habitNameController = TextEditingController();
  final List<Habit> _habits = [];
  final Map<String, int> _completionsByDay = {
    "Monday": 0,
    "Tuesday": 0,
    "Wednesday": 0,
    "Thursday": 0,
    "Friday": 0,
    "Saturday": 0,
    "Sunday": 0,
  };

  void _addHabit(String name) {
    setState(() {
      _habits.add(Habit(name: name));
    });
    _habitNameController.clear();
  }

  void _removeHabit(int index) {
    setState(() {
      _habits.removeAt(index);
    });
  }

  void _incrementDays(int index) {
    setState(() {
      _habits[index].days++;
      String today = _getToday();
      _completionsByDay[today] = (_completionsByDay[today] ?? 0) + 1;
    });
  }

  String _getToday() {
    final now = DateTime.now();
    switch (now.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _habits.isEmpty
                ? const Center(
                    child: Text(
                      "No habits yet! Add one using the button below.",
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
                        onUpdateDescription: (description) {
                          setState(() {
                            habit.description = description;
                          });
                        },
                      );
                    },
                  ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Completions This Week",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                for (var entry in _completionsByDay.entries)
                  Text(
                    "${entry.key}: ${entry.value}",
                    style: const TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
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
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Add Habit"),
            ),
          ),
        ],
      ),
    );
  }
}

class Habit {
  final String name;
  String description;
  int days;

  Habit({required this.name, this.description = "", this.days = 0});
}

class HabitCard extends StatefulWidget {
  final Habit habit;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final Function(String) onUpdateDescription;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onRemove,
    required this.onIncrement,
    required this.onUpdateDescription,
  });

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  bool _isHovered = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.habit.description;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color: const Color(0xFF3c3836),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.habit.name,
                style: const TextStyle(color: Color(0xFFebdbb2)),
              ),
              subtitle: Text(
                "Days Completed: ${widget.habit.days}",
                style: const TextStyle(color: Color(0xFF7c6f64)),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFF83a598)),
                    onPressed: widget.onIncrement,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFfb4934)),
                    onPressed: widget.onRemove,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habit.description.isNotEmpty
                        ? widget.habit.description
                        : "No description provided.",
                    style: const TextStyle(color: Color(0xFFbdae93)),
                  ),
                  if (_isHovered)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Edit description...",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          widget.habit.description = text;
                          widget.onUpdateDescription(text);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
