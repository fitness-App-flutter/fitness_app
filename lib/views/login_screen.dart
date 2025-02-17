import 'package:fitness_app/auth/authintication/login_cubit.dart';
import 'package:fitness_app/core/helper/snack_bar.dart';
import 'package:fitness_app/views/forgot_password_screen.dart';
import 'package:fitness_app/views/sign_up_screen.dart';
import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/custom_text_field.dart';
import 'package:fitness_app/widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late String? email, password;

  late GlobalKey<FormState> formKey = GlobalKey();

  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucess) {
          ShowDialog(context, 'Great to see you again');
          isLoading = false;
        } else if (state is LoginFalier) {
          showSnackBar(context, state.errorMassage);
          isLoading = false;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(child: ScreenTitle(title: "Welcome Back")),
                    const SizedBox(height: 80),
                    const Text("Email",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: "Enter your email",
                      onchange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Password",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter your password",
                      obscureText: true,
                       controller: TextEditingController(),
                      onchange: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen()));
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff626ae7))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Login",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .LoginUser(email: email!, password: password!);
                          return ShowDialog(context, 'Great to see you again');
                        }
                      },
                      backgroundColor: const Color(0xff626ae7),
                    ),
                    const SizedBox(height: 120),
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
                                    builder: (context) => const SignUpScreen()));
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
