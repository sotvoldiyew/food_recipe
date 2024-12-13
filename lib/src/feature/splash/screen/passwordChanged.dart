import 'package:flutter/material.dart';

import 'login_screen.dart';

class PasswordChanged extends StatefulWidget {
  const PasswordChanged({super.key});

  @override
  State<PasswordChanged> createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Image.asset('assets/images/img_1.png',
                height: 240,
              ),
              const SizedBox(height: 2),
              const Text(
                'Password Changed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Your password has been changed successfully ',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              // const Row(
              //   children: [
              //     SizedBox(
              //       width: 110,
              //     ),
              //     Text(
              //       textAlign: TextAlign.start,
              //       ' successfully ',
              //       style: TextStyle(
              //         fontSize: 17,
              //         fontWeight: FontWeight.w500,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF129575),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Back to Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}

