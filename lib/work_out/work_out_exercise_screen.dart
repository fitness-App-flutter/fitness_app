import 'package:fitness_app/work_out/exercises.dart';
import 'package:flutter/material.dart';

class WorkoutExercisesScreen extends StatelessWidget {
  const WorkoutExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ExerciseItem> exercises = [
      ExerciseItem(title: 'Chest', subtitle: 'Bench Press, Push-ups, Dumbbell Flys', icon: Icons.fitness_center, bgColor: const Color(0xFF7B61FF)),
      ExerciseItem(title: 'Back', subtitle: 'Pull-ups, Deadlifts, Rows', icon: Icons.fitness_center, bgColor: const Color(0xFFFFA63E)),
      ExerciseItem(title: 'Shoulders', subtitle: 'Overhead Press, Lateral Raises, Face Pulls', icon: Icons.fitness_center, bgColor: const Color(0xFFFF5252)),
      ExerciseItem(title: 'Arms', subtitle: 'Biceps Curls, Triceps Extensions, Forearm Curls', icon: Icons.fitness_center, bgColor: const Color(0xFF2ECC71)),
      ExerciseItem(title: 'Legs', subtitle: 'Squats, Lunges, Calf Raises', icon: Icons.fitness_center, bgColor: const Color(0xFF3498DB)),
      ExerciseItem(title: 'Core', subtitle: 'Planks, Crunch Variations, Hyperextensions', icon: Icons.fitness_center, bgColor: const Color(0xFFFF7043)),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7F7F7),
        centerTitle: true,
        title: const Text('Workout Exercises', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: ListTile(
              leading: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(color: item.bgColor, borderRadius: BorderRadius.circular(12)),
                child: Center(child: Icon(item.icon, color: Colors.white, size: 30)),
              ),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              subtitle: Text(item.subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExerciseScreen(title: item.title)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bgColor;

  ExerciseItem({required this.title, required this.subtitle, required this.icon, required this.bgColor});
}
