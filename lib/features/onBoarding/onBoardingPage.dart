import 'package:flower_delivery/features/onBoarding/bloc/onBoarding_cubit.dart';
import 'package:flower_delivery/features/onBoarding/bloc/onBoarding_event.dart';
import 'package:flower_delivery/features/onBoarding/bloc/onBoarding_state.dart';
import 'package:flower_delivery/features/signIn/signIn.dart';
import 'package:flower_delivery/features/signUp/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_delivery/home.dart';
import 'package:flower_delivery/features/onBoarding/widget/buildPage1.dart';
import 'package:flower_delivery/features/onBoarding/widget/buildPage2.dart';
import 'package:flower_delivery/features/onBoarding/widget/buildPage3.dart';
import 'package:flower_delivery/features/onBoarding/widget/welcomePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  final PageController controller = PageController();

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {

              
              return Container(
                padding: const EdgeInsets.only(bottom: 80),
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    context.read<OnboardingCubit>().changePage(index);
                  },
                  children: [
                    buildPage1(),
                    buildPage2(),
                    buildPage3(),
                    welcomePage(),
                  ],
                ),
              );
            },
          ),
          bottomSheet: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              bool isLastPage = false;
              if (state is OnboardingPageState) {
                isLastPage = state.isLastPage;
              }

              return isLastPage
                  ? Container(
                      height: 120,
                      child: Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // final prefs = await SharedPreferences.getInstance();
                                // prefs.setBool('showHome', true);

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              child: Text("Let's Get Started"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => SignIn()),
                                );
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      height: 80,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: state is OnboardingPageState && state.currentPage == 0 ? 0.0 : 1.0,
                            child: IconButton(
                              onPressed: state is OnboardingPageState && state.currentPage == 0
                                  ? null
                                  : () => controller.previousPage(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      ),
                              icon: const Icon(Icons.arrow_circle_left, size: 50),
                            ),
                          ),
                          Center(
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 4,
                              effect: WormEffect(
                                spacing: 16,
                                dotColor: Color.fromARGB(50, 101, 0, 178),
                                activeDotColor: Color.fromARGB(255, 101, 0, 178),
                              ),
                              onDotClicked: (index) {},
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                            icon: Icon(Icons.arrow_circle_right, size: 50),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
