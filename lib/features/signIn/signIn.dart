// ignore_for_file: prefer_const_constructors

import 'package:flower_delivery/features/signIn/bloc/bloc/sign_in_bloc.dart';
import 'package:flower_delivery/features/signIn/bloc/bloc/sign_in_event.dart';
import 'package:flower_delivery/features/signIn/bloc/bloc/sign_in_state.dart';
import 'package:flower_delivery/features/signIn/widget/socialButton.dart';
import 'package:flower_delivery/features/signUp/signUp.dart';
import 'package:flower_delivery/home.dart';
import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignInBloc(GoogleSignIn()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sz.height * 0.02),
                    const Text(
                      "Hi! Welcome back, you've been missed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: sz.height * 0.1),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.mainColor,
                        ),
                        labelText: 'Email',
                        hintText: 'example@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: sz.height * 0.04),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.mainColor,
                        ),
                        labelText: 'Password',
                        hintText: '*************',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: sz.height * 0.05),
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Or sign in with',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: sz.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Socialbutton(
                        //   image: 'assets/images/apple_logo.png',
                        //   onTap: () {
                        //     print('Apple');
                        //   },
                        // ),
                        Socialbutton(
                          image: 'assets/images/google_logo.png',
                          onTap: () {
                            context.read<SignInBloc>().add(SignInWithGoogle());
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            'Sign Up',
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
            );
            }
            else if (state is Authenticating) {
              return const Center(child: CircularProgressIndicator());
          } else if (state is Authenticated) {
             WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage()
                ),
              );
            });
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Error'));
          }
          },
        ),
      ),
    );
  }
}
