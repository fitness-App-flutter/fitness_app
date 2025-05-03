import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/table_widgets/workout_exercise_table.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_avatar.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_toggle_buttons.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/edit_text_field.dart';
import 'package:fitness_app/widgets/health_related_widgets/custom_slider.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/height_selector.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/update_profile_button.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text("Edit Profile"),
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
                  Center(child: const ProfileAvatar()),
                  const SizedBox(height: 20),

                  // Privacy Toggle Buttons
                  ProfileToggleButtons(
                    isPrivate: controller.isPrivate,
                    onInfoSelected: () {
                      controller.togglePrivacy(false); // Set privacy to false (Info mode)
                    },
                    onPrivacySelected: () {
                      controller.togglePrivacy(true); // Set privacy to true (Privacy mode)
                    },
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: UpdateProfileButton(
                      onPressed: () async {
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          email: controller.emailController.text,
                          weight: controller.weight,
                          height: controller.height,
                          isPrivate: controller.isPrivate,  // Ensure privacy is updated
                        );
                        Navigator.pop(context);  // Go back to Profile Screen
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Profile Information Fields
                  EditTextField(
                    controller: controller.nameController,
                    hintText: "Enter Name",
                  ),
                  const SizedBox(height: 10),

                  EditTextField(
                    controller: controller.emailController,
                    hintText: "Enter Email",
                  ),
                  const SizedBox(height: 20),

                  // Weight and Height Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Weight slider
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Weight (Kg)",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomSlider(
                                    value: controller.weight,
                                    min: 30,
                                    max: 250,
                                    onChanged: (value) => controller.updateWeight(value),
                                    color: MyColors.PrimaryBlue,
                                    tooltipColor: MyColors.PrimaryBlue,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: MyColors.PrimaryBlue),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${controller.weight.toInt()} Kg",
                                    style: TextStyle(
                                      color: MyColors.PrimaryBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Height selector
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Height (cm)",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            HeightSelector(
                              height: controller.height.toInt(),
                              onIncrease: () {
                                if (controller.height < 250) {
                                  controller.updateHeight(controller.height + 1);
                                }
                              },
                              onDecrease: () {
                                if (controller.height > 50) {
                                  controller.updateHeight(controller.height - 1);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Workout Table (for demo purposes)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: WorkoutTable(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
