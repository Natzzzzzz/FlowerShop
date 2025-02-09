import 'package:flutter/material.dart';

class Socialbutton extends StatelessWidget {
  final String image;
  final Function()? onTap;
  const Socialbutton({super.key, required this.image, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: EdgeInsets.all(sz.width * 0.04),
          child: Image.asset(
            image,
            fit: BoxFit.contain,),
        ),
      ),
    );
  }
}