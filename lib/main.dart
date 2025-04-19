import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fitness_app/screens/overview_page.dart';
import 'package:fitness_app/screens/sleep_page.dart';
import 'package:fitness_app/screens/steps_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const OverviewPage(),
    const StepsPage(),
    const SleepPage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: 'Steps'),
          BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sleep'),
        ],
      ),
    );
  }
}
