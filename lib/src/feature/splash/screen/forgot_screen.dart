import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/verification_code/screen/verification_screen.dart';
import 'package:go_router/go_router.dart';

import '../../verification_code/screen/refresh_code_otp_page.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController emailController = TextEditingController();

  Future<void> requestPasswordReset(String email) async {
    String? token = context.dependencies.shp.getString("token");
    if (token != null) {
      log("email: $email");
      String? result = await NetworkService.post(api: Urls.requestPasswordReset, context: context, data: {"email": email});
      if (result != null) {
        log(" data mavjud $result");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RefreshCodeOtpPage(email: email)),
        );
        emailController.clear();
      } else {
        log("data mavjud emas $result");
        emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Something went wrong",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3), // Optional: duration of the Snackbar
            behavior: SnackBarBehavior.floating, // Optional: floating Snackbar style
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 140,
            ),
            Text(
              textAlign: TextAlign.start,
              'Find your account',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              textAlign: TextAlign.start,
              'Enter your email address',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff121212),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                labelStyle: const TextStyle(color: Color(0xffD9D9D9)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: false,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await requestPasswordReset(emailController.text);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF129575),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
