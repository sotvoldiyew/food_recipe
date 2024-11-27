import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/splash/screen/new_password.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  get focusedPinTheme => null;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(10),
      textStyle: context.textTheme.bodyLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8ECF4)
        ),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF129575)),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF129575),),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp,
          color: Colors.black,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              "OTP Verification",
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the verification code we just sent on your email address",
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
            ),

            const SizedBox(height: 40),
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              keyboardType: TextInputType.number,
              onCompleted: (pin) {
                print("Verification Code Entered: $pin");
              },
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.push(
                  //  context,
                   // MaterialPageRoute(builder: (context) => NewPassword()),
                 // );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF129575),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: Center(
                  child: Text(
                    "Continue",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't received code? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewPassword()),
                    );
                  },
                  child: const Text(
                    'Resend',
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
