import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/auth/authintication/login_cubit.dart';
import 'package:fitness_app/auth/authintication/reset_password_cubit.dart';
import 'package:fitness_app/auth/authintication/sign_up_cubit.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/screens/profile_screen.dart';
import 'package:fitness_app/screens/steps_page.dart';
import 'package:fitness_app/views/sign_up_screen.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/screens/health_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized before running the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,  // Enable DevicePreview only in development mode
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProfileController()),
          ChangeNotifierProvider(create: (_) => NutrientProvider()),
        ],
        child: const MyApp(),
      ),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: _getInitialScreen(),  // Determine the initial screen based on login state
      ),
    );
  }

  // This method checks if the user is logged in, if yes, show ProfileScreen, else show SignUpScreen
  Widget _getInitialScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If user is logged in, show the ProfileScreen
      return HealthScreen();
    } else {
      // If user is not logged in, show the SignUpScreen
      return SignUpScreen();
    }
  }
}

