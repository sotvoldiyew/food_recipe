import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/splash/screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              textAlign: TextAlign.start,
              'Create an account',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              textAlign: TextAlign.start,
              'Let’s help you set up your account,',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xff121212),
              ),
            ),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'it won’t take long.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff121212),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Name',
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
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                labelStyle: const TextStyle(
                    color: Color(0xffD9D9D9),
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
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
                labelStyle: const TextStyle(
                    color: Color(0xffD9D9D9),
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
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
                  'Password',
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
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                labelStyle: const TextStyle(
                    color: Color(0xffD9D9D9),
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
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
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Confirm Password',
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
              controller: passwordConfirmController,
              decoration: InputDecoration(
                labelText: 'Retype Password',
                labelStyle: const TextStyle(
                    color: Color(0xffD9D9D9),
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
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
            Row(
              children: [
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          color: Colors.orange,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: Colors.orange,
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'Accept terms & Condition',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF129575),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: context.textTheme.titleMedium
                          ?.copyWith(color: context.colors.onPrimary),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 15),
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Color(0xffFF9C00),
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
