import 'package:fitness_app/auth/cubit/reset_password_cubit.dart';
import 'package:fitness_app/auth/widges/custom_button.dart';
import 'package:fitness_app/auth/widges/custom_text_field.dart';
import 'package:fitness_app/auth/widges/screen_title.dart';
import 'package:fitness_app/core/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showSnackBar(context, state.message);
        }
        if (state is PasswordChanged) {
          showSnackBar(context, 'Password was changed successfully!');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const ScreenTitle(title: "Forget Password"),
                    ],
                  ),
                  const SizedBox(height: 80),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "Enter email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Send Code",
                    onPressed: () => context
                        .read<AuthCubit>()
                        .sendVerificationCode(emailController.text),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
