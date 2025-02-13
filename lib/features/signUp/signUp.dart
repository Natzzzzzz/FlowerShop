import 'package:flower_delivery/features/signIn/signIn.dart';
import 'package:flower_delivery/features/signUp/bloc/sign_up_bloc.dart';
import 'package:flower_delivery/features/signUp/bloc/sign_up_event.dart';
import 'package:flower_delivery/features/signUp/bloc/sign_up_state.dart';
import 'package:flower_delivery/features/signUp/cubit/cf_password_cubit.dart';
import 'package:flower_delivery/features/signUp/cubit/password_cubit.dart';
import 'package:flower_delivery/features/signUp/verifyEmail.dart';
import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Thêm GlobalKey để quản lý form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => ConfirmPasswordVisibilityCubit()),
        BlocProvider(create: (_) => SignUpBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey, // Bọc các TextField trong Form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sz.height * 0.02),
                  const Text(
                    "Fill your information below or register \nwith your social account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: sz.height * 0.1),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppColors.mainColor),
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: sz.height * 0.02),

                  // Password Field
                  BlocBuilder<PasswordVisibilityCubit, bool>(
                    builder: (context, isPasswordVisible) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: AppColors.mainColor),
                          labelText: 'Password',
                          hintText: '*************',
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              context.read<PasswordVisibilityCubit>().toggleVisibility();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: sz.height * 0.02),

                  // Confirm Password Field
                  BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                    builder: (context, isConfirmPasswordVisible) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập lại mật khẩu';
                          }
                          if (value != _passwordController.text) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: AppColors.mainColor),
                          labelText: 'Confirm Password',
                          hintText: '*************',
                          suffixIcon: IconButton(
                            icon: Icon(isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              context.read<ConfirmPasswordVisibilityCubit>().toggleVisibility();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      );
                    },
                  ),
                  // SizedBox(height: sz.height * 0.005),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text("Sign Up Successful!"), backgroundColor: Colors.green,),
                        // );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => VerifyEmail()),
                        );
                      } else if (state is SignUpFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is SignUpLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignUpBloc>().add(
                                        SignUpSubmitted(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                        ),
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: state is SignUpLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18),
                              ),
                      );
                    },
                  ),

                  SizedBox(height: sz.height * 0.05),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            decoration: TextDecoration.underline,
                          ),
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
    );
  }
}
