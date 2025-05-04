import 'package:fitness_app/auth/authintication/sign_up_cubit.dart';
import 'package:fitness_app/core/helper/snack_bar.dart';
import 'package:fitness_app/screens/profile_screen.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/views/login_screen.dart';
import 'package:fitness_app/widges/custom_button.dart';
import 'package:fitness_app/widges/custom_dropdown.dart';
import 'package:fitness_app/widges/custom_slider.dart';
import 'package:fitness_app/widges/custom_text_field.dart';
import 'package:fitness_app/widges/height_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedHealth;
  String? selectedTarget;
  double weight = 50;
  int height = 170;
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (BuildContext context, state) {
        if (state is SignupLoading) {
          isLoading = false;
        } else if (state is SignupSuccess) {
          ShowDialog(
              context, 'Welcome to the family!\n Your journey starts now');
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );

        } else if (state is SignupFailure) {
          showSnackBar(context, state.error);
          isLoading = false;
        }
      },
      builder: (BuildContext context, SignupState state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    const Center(
                      child: Text(
                        "Let's Begin Journey 👋",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Name, Email & Password Fields
                    const Text("Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const CustomTextField(hintText: "Enter name"),
                    const SizedBox(height: 20),

                    const Text("Email",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter email",
                      onchange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 10),

                    const Text("Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      onchange: (data) {
                        password = data;
                      },
                      hintText: "Enter password",
                      obscureText: true,
                      suffixIcon: const Icon(Icons.visibility_off),
                    ),
                    const SizedBox(height: 10),

                    // Health & Target Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            label: "Health Check",
                            hint: "Health Situation",
                            value: selectedHealth,
                            items: const [
                              "Healthy",
                              "Underweight",
                              "Overweight"
                            ],
                            onChanged: (value) =>
                                setState(() => selectedHealth = value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomDropdown(
                            label: "Target",
                            hint: "Your Target",
                            value: selectedTarget,
                            items: const [
                              "Lose Weight",
                              "Gain Muscle",
                              "Stay Fit"
                            ],
                            onChanged: (value) =>
                                setState(() => selectedTarget = value),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Weight & Height Selectors
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSlider(
                              label: "Weight (Kg)",
                              value: weight,
                              min: 30,
                              max: 150,
                              divisions: 120,
                              onChanged: (value) =>
                                  setState(() => weight = value),
                            ),
                          ),
                          const SizedBox(width: 10),
                          HeightSelector(
                            height: height,
                            onDecrease: () => setState(() =>
                                height = height > 100 ? height - 1 : height),
                            onIncrease: () => setState(() =>
                                height = height < 220 ? height + 1 : height),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Sign-Up Button
                    Center(
                      child: CustomButton(
                        text: "Sign Up",
                        backgroundColor: MyColors.blue_register,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                            final siginUpEvent =
                                BlocProvider.of<SignupCubit>(context);
                            siginUpEvent.signUp(
                                height: height,
                                healthStatus: selectedHealth!,
                                target: selectedTarget!,
                                weight: weight,
                                email: email!,
                                password: password!);
                            return ShowDialog(context,
                                'Welcome to the family!\n Your journey starts now');
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Sign-In Link
                    Row(
                      children: [
                        const Text("Do you have an account?"),
                        TextButton(
                          onPressed: () {},
                          child:  Text(
                            "Sign in",
                            style: TextStyle(color: MyColors.blue_register),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}