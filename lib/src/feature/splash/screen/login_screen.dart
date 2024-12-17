import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/splash/screen/forgot_screen.dart';
import 'package:food_recipe/src/feature/sign_up/screen/signup_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../common/service/api_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String errorResponse;
  bool isLoading = false;

  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
    ),
  );

  Future<bool> loginUser(Map<String, String> userData,
      {required BuildContext context}) async {
    final apiService = ApiService(dio: dio);

    try {
      final response = await apiService.request(
        Urls.singIn,
        method: Method.post,
        data: userData,
      );
      log("try ishladi");
      if (response['data'] != null && response["status"] != false) {
        log("if ishladi try catchdagi");
        context.dependencies.shp.setString("email", emailController.text);
        context.dependencies.shp
            .setString("token", response["data"].toString());
        debugPrint('data: ${response['data']}');
        debugPrint(
            " shpga saqlandi ${context.dependencies.shp.getString("token")}");

        return true;
      } else {
        log("else ishladi try catchdagi");
        errorResponse = "Email yoki parol xato!";
        debugPrint(errorResponse);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse)),
        );
        return false;
      }
    } catch (e) {
      log("catch ishladi try catchdagi");
      errorResponse = "Email or Password incorrect!";
      debugPrint('Kirish xatoligi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  errorResponse,
                  style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onPrimary),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent.shade700,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: "Dismiss",
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
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
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email!';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Invalid email!';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password!';
                  }
                  if (value.length < 1) {
                    return 'Password must be at least 6 characters long.!';
                  }
                  return null;
                },
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
              MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: context.colors.primary,
                height: 55,
                minWidth: double.infinity,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });

                    bool isLoggedIn = await loginUser({
                      'password': passwordController.text,
                      'email': emailController.text,
                    }, context: context);

                    log("is logged in: $isLoggedIn");

                    setState(() {
                      isLoading = false;
                    });

                    if (isLoggedIn) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Successfully Logged In!",
                                  style: context.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colors.onPrimary),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.green.shade700,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 3),
                          elevation: 6,
                          action: SnackBarAction(
                            label: "Dismiss",
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          animation: CurvedAnimation(
                            parent: AnimationController(
                              vsync: ScaffoldMessenger.of(context),
                              duration: const Duration(milliseconds: 300),
                            ),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      );

                      context.go(AppRouter.home);
                    } else {}
                  } else {
                    debugPrint('Formda xatolar mavjud!');
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: context.colors.onPrimary,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: context.colors.onPrimary),
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
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: context.colors.primary,
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
      ),
    );
  }
}
