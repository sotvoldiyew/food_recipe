import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../common/router/app_router.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  void checkUser(){
    log("chec user func");
    String? token = context.dependencies.shp.getString("token");
    log("token $token");
    if(token != null){
      log("token != null");
      context.go(AppRouter.home);
    }else{
      log("token = null");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignInScreen()),
      );
    }
  }



  @override
  void initState() {
    Timer(const Duration(seconds: 2), (){
      log("init");
      checkUser();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Image.asset(
                    'assets/images/white_hat.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text('100K+ Premium Recipe',
                      style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colors.onPrimary,
                          fontSize: 20)),
                  const Expanded(child: SizedBox()),
                  Text('Get\n Cooking',
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colors.onPrimary)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Simple way to find Tasty Recipe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  // MaterialButton(
                  //   height: 50,
                  //   color: context.colors.primary,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   onPressed: () {
                  //
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const SignInScreen()),
                  //     );
                  //   },
                  //   child: const Center(
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           'Start Cooking',
                  //           style: TextStyle(color: Colors.white, fontSize: 16),
                  //         ),
                  //         SizedBox(width: 12),
                  //         Icon(
                  //           Icons.arrow_forward,
                  //           color: Colors.white,
                  //           size: 20,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
