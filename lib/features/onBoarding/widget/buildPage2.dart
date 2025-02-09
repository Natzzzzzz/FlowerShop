import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';

class buildPage2 extends StatefulWidget {
  

  const buildPage2({
    super.key});

  @override
  State<buildPage2> createState() => _buildPage2State();
}

class _buildPage2State extends State<buildPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onBoarding2.jpg',
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
                    const TextSpan(
                      text: 'Craft Your ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: 'Ultimate\n Floral Collection',
                      style: TextStyle(
                        color: AppColors.mainColor ,
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