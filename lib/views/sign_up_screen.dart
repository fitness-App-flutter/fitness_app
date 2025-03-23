import 'package:flutter/material.dart';
import 'package:test_app/widgets/colors.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_dropdown.dart';
import 'package:test_app/widgets/custom_slider.dart';
import 'package:test_app/widgets/custom_text_field.dart';
import 'package:test_app/widgets/height_selector.dart';

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
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
             Center(
              child:  const Text(
              "Let's Begin Journey 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ),
            
            
            const SizedBox(height: 20),
            
            // Name, Email & Password Fields
            const Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CustomTextField( hintText: "Enter name"),
            const SizedBox(height: 20),

           
            const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Enter email"),
            const SizedBox(height: 10),
            

            const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Enter password", obscureText: true, suffixIcon: Icon(Icons.visibility_off),),
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
                    items: ["Healthy", "Underweight", "Overweight"],
                    onChanged: (value) => setState(() => selectedHealth = value),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdown(
                    label: "Target",
                    hint: "Your Target",
                    value: selectedTarget,
                    items: ["Lose Weight", "Gain Muscle", "Stay Fit"],
                    onChanged: (value) => setState(() => selectedTarget = value),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Weight & Height Selectors
            Row(
              children: [
                Expanded(
                  child: CustomSlider(
                    label: "Weight (Kg)",
                    value: weight,
                    min: 30,
                    max: 150,
                    divisions: 120,
                    onChanged: (value) => setState(() => weight = value),
                  ),
                ),
                const SizedBox(width: 10),
                HeightSelector(
                  height: height,
                  onDecrease: () => setState(() => height = height > 100 ? height - 1 : height),
                  onIncrease: () => setState(() => height = height < 220 ? height + 1 : height),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Sign-Up Button
            Center(
              child: CustomButton(
                text: "Sign Up",
                backgroundColor:  MyColors.bluee,
                textColor:  MyColors.white,
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 10),

            // Sign-In Link
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Do you have an account? Sign in"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}