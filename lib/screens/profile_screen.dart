import 'package:flutter/material.dart';
import 'package:fitness_app/screens/edit_profile_screen.dart';
import 'package:fitness_app/widgets/password_related_widgets/changing_password.dart';
import 'package:fitness_app/widgets/profile_related_widgets/info_related_widgets/profile_info.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_avatar.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_toggle_buttons.dart';
import 'package:fitness_app/widgets/table_widgets/workout_exercise_table.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),  // ProfileController is being provided here
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: MyColors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer<ProfileController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfileAvatar(),
                    const SizedBox(height: 20),
                    ProfileToggleButtons(
                      isPrivate: controller.isPrivate,
                      onInfoSelected: () => controller.togglePrivacy(false),
                      onPrivacySelected: () => controller.togglePrivacy(true),
                    ),
                    const SizedBox(height: 20),
                    controller.isPrivate
                        ? buildPasswordChangeScreenUI(
                      context,
                      controller.isPrivate,
                          () => controller.togglePrivacy(false),
                          () => controller.togglePrivacy(true),
                    )
                        : Column(
                      children: [
                        // Your profile info widget here
                        ProfileInfo(
                          name: controller.name,
                          email: controller.email,
                          weight: controller.weight.toInt().toString(),
                          height: controller.height.toInt().toString(),
                          onEditPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            ).then((_) => controller.reloadProfile());  // Reload profile after editing
                          },
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: WorkoutTable(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
