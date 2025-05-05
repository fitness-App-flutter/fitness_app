import 'package:fitness_app/auth/cubit/login_cubit.dart';
import 'package:fitness_app/auth/views/forgot_password_screen.dart';
import 'package:fitness_app/auth/views/sign_up_screen.dart';
import 'package:fitness_app/auth/widges/custom_button.dart';
import 'package:fitness_app/auth/widges/custom_text_field.dart';
import 'package:fitness_app/auth/widges/screen_title.dart';
import 'package:fitness_app/core/helper/snack_bar.dart';
import 'package:fitness_app/screens/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fitness_app/screens/profile_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() => isLoading = true);
        } else if (state is LoginSuccess) {
          setState(() => isLoading = false);
          ShowDialog(context, 'Great to see you again');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OverviewPage()),
          );
        } else if (state is LoginFailure) {
          setState(() => isLoading = false);
          showSnackBar(context, state.error);
        }
      },
      child: ModalProgressHUD(
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
                    const SizedBox(height: 40),
                    const Center(child: ScreenTitle(title: "Welcome Back")),
                    const SizedBox(height: 80),

                    // Email
                    const Text("Email",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter your email",
                      controller: emailController,
                      onchange: (data) => email = data,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password
                    const Text("Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter your password",
                      obscureText: true,
                      controller: passwordController,
                      onchange: (data) => password = data,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: const Text("Forgot Password?",
                            style:
                            TextStyle(fontSize: 14, color: Color(0xff626ae7))),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          BlocProvider.of<LoginCubit>(context).login(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                      backgroundColor: const Color(0xff626ae7),
                    ),

                    const SizedBox(height: 120),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(fontSize: 14)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SignUpScreen()));
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff626ae7))),
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
