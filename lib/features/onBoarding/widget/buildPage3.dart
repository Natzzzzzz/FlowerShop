import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';

class buildPage3 extends StatefulWidget {
  

  const buildPage3({
    super.key});

  @override
  State<buildPage3> createState() => _buildPage3State();
}

class _buildPage3State extends State<buildPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onBoarding3.jpg',
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
                text:  TextSpan(
                  children: [
                    TextSpan(
                      text: 'From Cart to Door:',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const TextSpan(
                      text: ' Swift &\n Reliable Flower Delivery',
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