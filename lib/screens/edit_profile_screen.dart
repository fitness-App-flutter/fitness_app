import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/table_widgets/workout_exercise_table.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_avatar.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_toggle_buttons.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/edit_text_field.dart';
import 'package:fitness_app/widgets/health_related_widgets/custom_slider.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/height_selector.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_related_widgets/update_profile_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<ProfileController>(context, listen: false);
    _initFuture = controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profileController = Provider.of<ProfileController>(context);

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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(child: ProfileAvatar()),
                  const SizedBox(height: 20),
                  ProfileToggleButtons(
                    isPrivate: profileController.isPrivate,
                    onInfoSelected: () => profileController.togglePrivacy(false),
                    onPrivacySelected: () => profileController.togglePrivacy(true),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: UpdateProfileButton(
                      onPressed: () async {
                        await profileController.updateProfile(
                          name: profileController.nameController.text,
                          email: profileController.emailController.text,
                          weight: profileController.weight,
                          height: profileController.height,
                          isPrivate: profileController.isPrivate,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  EditTextField(
                    controller: profileController.nameController,
                    hintText: "Enter Name",
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                    value: profileController.weight,
                                    min: 30,
                                    max: 180,
                                    onChanged: (value) => profileController.updateWeight(value),
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
                                    "${profileController.weight.toInt()} Kg",
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
                              value: profileController.height,
                              min: 120,
                              max: 220,
                              onChanged: (value) => profileController.updateHeight(value),
                              height: profileController.height.toInt(),
                              onIncrease: () {
                                if (profileController.height < 180) {
                                  profileController.updateHeight(profileController.height + 1);
                                }
                              },
                              onDecrease: () {
                                if (profileController.height > 50) {
                                  profileController.updateHeight(profileController.height - 1);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
