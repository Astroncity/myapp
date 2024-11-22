import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  //list of Habits
    static final List<Habit> habits = [
        Habit('n'),
        Habit('Read'),
        Habit('Meditate'),
        Habit('Drink Water'),
        Habit('Sleep'),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text('Habits'),
        ),
        body: ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
            return ListTile(
                title: Text(habits[index].name),
                onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => habits[index],
                    ),
                );
                },
            );
            },
        ),
        );
    }

}


class Habit extends StatefulWidget{
    final String name;
    Habit(this.name);
    @override
    HabitState createState() => HabitState(name, 0); 
}


//holds a name and a number of days completed (currently redundant)
class HabitState extends State<Habit>{
    String name;
    int daysCompleted;
    HabitState(this.name, this.daysCompleted);
    void incrementDays(){
        setState(() => daysCompleted++); 
    }
    void decrementDays(){
        setState(() => daysCompleted--);
    }
    @override
    Widget build(BuildContext context){
        return Scaffold(
        appBar: AppBar(
            title: Text(name),
        ),
        body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(
                'Days Completed: $daysCompleted',
                style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ElevatedButton(
                    onPressed: decrementDays,
                    child: const Text('Decrement'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                    onPressed: incrementDays,
                    child: const Text('Increment'),
                    ),
                ],
                ),
            ],
            ),
        ),
        );
    }
}
