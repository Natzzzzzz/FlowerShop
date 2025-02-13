import 'package:flower_delivery/features/onBoarding/onBoardingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingPage(),
                ),
              );
              
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
          child:  Text("Home page"),
      ),
    );
  }
}