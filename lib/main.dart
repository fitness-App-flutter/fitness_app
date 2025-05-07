import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/auth/cubit/login_cubit.dart';
import 'package:fitness_app/auth/cubit/reset_password_cubit.dart';
import 'package:fitness_app/auth/cubit/sign_up_cubit.dart';
import 'package:fitness_app/auth/views/health_journey_screen.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/screens/health_screen.dart';
import 'package:fitness_app/screens/profile_screen.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';
import 'package:fitness_app/widgets/profile_related_widgets/info_related_widgets/profile_image_cubit/image_cubit.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'auth/views/sign_up_screen.dart';
import 'package:fitness_app/widgets/profile_related_widgets/app_routes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProfileController()),
            ChangeNotifierProvider(create: (_) => NutrientProvider()),
          ],
          child: const MyApp(),
        )
    ),
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
        BlocProvider(create: (context) => ProfileCubit())
      ],
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
        home: SignUpScreen(),
      ),
    );
  }

  Widget _getInitialScreen() {
    final user = FirebaseAuth.instance.currentUser;
     return SignUpScreen();

  }
}