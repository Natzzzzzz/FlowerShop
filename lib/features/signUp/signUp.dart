import 'package:flower_delivery/features/signIn/signIn.dart';
import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return Scaffold (
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                style: TextStyle(fontSize: 14, color: Colors.grey,fontFamily: 'Inter',),
              ),
               SizedBox(height: sz.height * 0.1),
               TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people, color: AppColors.mainColor,),
                  labelText: 'Name',
                  hintText: 'EX: John Doe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: sz.height * 0.04),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: AppColors.mainColor,),
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
                  prefixIcon: Icon(Icons.lock, color: AppColors.mainColor,),
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
                    style: TextStyle(color: AppColors.mainColor, decoration: TextDecoration.underline,),
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
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
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
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    child:  Text(
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
    );
  }
}