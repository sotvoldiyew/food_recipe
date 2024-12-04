import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/splash/screen/forgot_screen.dart';
import 'package:food_recipe/src/feature/splash/screen/signup_screen.dart';
import 'package:go_router/go_router.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const Spacer(),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Hello,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff121212),
                  ),
                ),
              ],
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
            TextField(keyboardType: TextInputType.emailAddress,
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
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Enter Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff121212),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                labelStyle: const TextStyle(color: Color(0xffD9D9D9)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotScreen()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Color(0xffFF9C00),
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF129575),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: context.textTheme.titleMedium?.copyWith(color: context.colors.onPrimary),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xffD9D9D9),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Or Sign In With',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffD9D9D9)),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xffD9D9D9),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  height: 70,
                  minWidth: 70,
                  color: const Color(0xffFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Image.asset(
                    'assets/images/icon_google.png',
                    height: 25,
                  ),
                ),
                /* const SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 55,
                  minWidth: 55,
                  color: const Color(0xffFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    'assets/images/facebook.png',
                    height: 27,
                  ),
                ),*/
              ],
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Color(0xffFF9C00),
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}