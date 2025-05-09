import 'package:fitness_app/work_out/exercise_details_screan.dart';
import 'package:flutter/material.dart';
import 'exersice_title_images/title_images.dart';

class ExerciseScreen extends StatelessWidget {
  final String title;

  const ExerciseScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  List<ExerciseDetail> get _exercises {
    final lowerTitle = title.toLowerCase();

    final exercisesMap = {
      'chest': [
        {'name': 'Bench Press', 'reps': '3 sets × 8-12 reps'},
        {'name': 'Fly Machine', 'reps': '3 sets × 10-15 reps'},
        {'name': 'Incline Bench Press', 'reps': '3 sets × 8-12 reps'},
      ],
      'arms': [
        {'name': 'Bicep Curl', 'reps': '3 sets × 10-15 reps'},
        {'name': 'Forearm Curl', 'reps': '3 sets × 12-15 reps'},
        {'name': 'Tricep Extension', 'reps': '3 sets × 8-12 reps'},
      ],
      'back': [
        {'name': 'Deadlift', 'reps': '3 sets × 6-8 reps'},
        {'name': 'Pull-Ups', 'reps': '3 sets × 8-10 reps'},
        {'name': 'One-Arm Dumbbell Row', 'reps': '3 sets × 8-10 reps'},
      ],
      'shoulders': [
        {'name': 'Overhead Press', 'reps': '3 sets × 8-12 reps'},
        {'name': 'Lateral Raises', 'reps': '3 sets × 10-15 reps'},
        {'name': 'Face Pulls', 'reps': '3 sets × 10-15 reps'},
      ],
      'legs': [
        {'name': 'Squats', 'reps': '3 sets × 8-12 reps'},
        {'name': 'Lunges', 'reps': '3 sets × 10-12 reps'},
        {'name': 'Calf Raises', 'reps': '3 sets × 12-15 reps'},
      ],
      'core': [
        {'name': 'Crunch', 'reps': '3 sets × 15-20 reps'},
        {'name': 'Plank', 'reps': '3 sets × 30-60 sec'},
        {'name': 'Hyperextension', 'reps': '3 sets × 15 reps'},
      ],
    };

    final gifsMap = {
      'chest': [ExercisesGifs.benchPress, ExercisesGifs.flyMachine, ExercisesGifs.inclineBenchPress],
      'arms': [ExercisesGifs.bicepCurl, ExercisesGifs.forearm, ExercisesGifs.tricepExtension],
      'back': [ExercisesGifs.deadLift, ExercisesGifs.pullUps, ExercisesGifs.oneDumbbellRow],
      'shoulders': [ExercisesGifs.overHead, ExercisesGifs.lateralRaises, ExercisesGifs.facePulls],
      'legs': [ExercisesGifs.squats, ExercisesGifs.lunges, ExercisesGifs.calfRaises],
      'core': [ExercisesGifs.crunch, ExercisesGifs.plank, ExercisesGifs.hyperExtension],
    };

    return List.generate(3, (index) => ExerciseDetail(
      name: exercisesMap[lowerTitle]![index]['name']!,
      repsCounts: exercisesMap[lowerTitle]![index]['reps']!,
      imageUrl: gifsMap[lowerTitle]![index],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final imageAsset = {
      'chest': ExerciseImages.chest,
      'back': ExerciseImages.back,
      'shoulders': ExerciseImages.shoulders,
      'arms': ExerciseImages.arms,
      'legs': ExerciseImages.legs,
      'core': ExerciseImages.core,
    }[title.toLowerCase()];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                if (imageAsset != null)
                  Image.asset(imageAsset, height: 300, width: double.infinity, fit: BoxFit.cover)
                else
                  Container(height: 300, color: Colors.grey),
                Container(height: 300, color: Colors.black.withOpacity(0.3)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.pop(context)),
                        Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        const Icon(Icons.info_outline, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return ListTile(
                  leading: Image.asset(exercise.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                  title: Text(exercise.name),
                  subtitle: Text(exercise.repsCounts,style: const TextStyle(fontSize: 25),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetailScreen(
                          name: exercise.name,
                          reps: exercise.repsCounts,
                          imageUrl: exercise.imageUrl,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetail {
  final String name;
  final String repsCounts;
  final String imageUrl;

  ExerciseDetail({
    required this.name,
    required this.repsCounts,
    required this.imageUrl,
  });
}
