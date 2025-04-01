import 'package:flutter/material.dart';
import 'package:flutter_projects_1/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_projects_1/widgets/profile_related_widgets/profile_controller.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/nutrient_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => NutrientProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ProfileScreen(),
      ),
    );
  }
}