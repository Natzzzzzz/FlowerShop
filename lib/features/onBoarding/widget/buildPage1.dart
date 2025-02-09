import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';

class buildPage1 extends StatefulWidget {
  

  const buildPage1({
    super.key});

  @override
  State<buildPage1> createState() => _buildPage1State();
}

class _buildPage1State extends State<buildPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onBoarding1.jpg',
            fit:BoxFit.cover,
            width: double.infinity,),
            const SizedBox(height: 30,),
            Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Seamless ',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const TextSpan(
                      text: 'Flower\n Shopping Experience',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}