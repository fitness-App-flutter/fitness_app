import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/custom_dropdown.dart';
import 'package:fitness_app/widgets/custom_slider.dart';
import 'package:fitness_app/widgets/custom_text_field.dart';
import 'package:fitness_app/widgets/height_selector.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
               const Center(
                child:  Text(
                "Let's Begin Journey 👋",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      items: const ["Healthy", "Underweight", "Overweight"],
                      onChanged: (value) => setState(() => selectedHealth = value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomDropdown(
                      label: "Target",
                      hint: "Your Target",
                      value: selectedTarget,
                      items: const ["Lose Weight", "Gain Muscle", "Stay Fit"],
                      onChanged: (value) => setState(() => selectedTarget = value),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 10),
          
              // Weight & Height Selectors
              Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Row(
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
              ),
          
              const SizedBox(height: 60),
          
              // Sign-Up Button
              Center(
                child: CustomButton(
                  text: "Sign Up",
                  backgroundColor: const Color(0xff626ae7),
                  onPressed: () {},
                ),
              ),
          
              const SizedBox(height: 30),
          
              // Sign-In Link
              Row(
                children: [
                  const Text("Do you have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Sign in",style: TextStyle(color: Color(0xff626ae7)),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}