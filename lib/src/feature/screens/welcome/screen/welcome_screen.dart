import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Start"),
            MaterialButton(
              onPressed: () {
                context.go(AppRouter.home);
              },
              shape: StadiumBorder(side: BorderSide(color: Colors.white)),
              child: Text("Go Next"),
            )
          ],
        ),
      ),
    );
  }
}
