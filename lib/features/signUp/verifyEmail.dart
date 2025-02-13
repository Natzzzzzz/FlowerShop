import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_delivery/features/signIn/signIn.dart';
import 'package:flower_delivery/home.dart';
import 'package:flower_delivery/misc/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 1), (_) => checkEmailVerified());
    }
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      timer?.cancel(); // Hủy timer nếu người dùng đã đăng xuất
      return;
    }

    await user.reload();

    setState(() {
      isEmailVerified = user.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      print("An error occured while sending email verification");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    if (isEmailVerified) {
      return HomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Verify Email",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: sz.height * 0.1),
              const Text(
                "An verification email has been sent to your email address. Please verify",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sz.height * 0.05),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  foregroundColor: Colors.white,
                  minimumSize: Size(sz.width * 0.5, 50),
                ),
                onPressed: canResendEmail ? sendVerificationEmail : null,
                icon: Icon(Icons.email),
                label: const Text("Resend Email"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
