import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/splash/screen/login_screen.dart';
import 'package:food_recipe/src/feature/splash/screen/new_password.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../common/constants/constants.dart';

class RefreshCodeOtpPage extends StatefulWidget {
  const RefreshCodeOtpPage({super.key, required this.email});

  final String email;

  @override
  State<RefreshCodeOtpPage> createState() => _RefreshCodeOtpPageState();
}

class _RefreshCodeOtpPageState extends State<RefreshCodeOtpPage> {
  TextEditingController smsCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  get focusedPinTheme => null;
  bool isLoading = false;
  late String pinText;

  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
    ),
  );

  Future<void> reSendCode() async {}

  Future<void> verification({required String code, required String newPassword}) async {
    String? result = await NetworkService.post(
        api: Urls.refreshPassword, context: context, data: {"email": widget.email, "code": code, "newPassword": newPassword});

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Parol Muvaffaqiyatli yangilandi!"), backgroundColor: Colors.green));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Code error!",
                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: context.colors.onPrimary),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      textStyle: context.textTheme.bodyLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF4)),
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
        border: Border.all(color: const Color(0xFF129575)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              "Refresh Code OTP Verification",
              style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the verification code we just sent on your email address",
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            const Align(alignment: Alignment.topLeft, child: Text(" Enter Sms Code: ")),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              keyboardType: TextInputType.number,
              controller: smsCtrl,
              onCompleted: (pin) => pinText = pin,
            ),
            const SizedBox(height: 50),
            const Align(alignment: Alignment.topLeft, child: Text(" Enter new Password: ")),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              keyboardType: TextInputType.number,
              controller: passCtrl,
              onCompleted: (pin) => pinText = pin,
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () async => await verification(code: smsCtrl.text, newPassword: passCtrl.text),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF129575),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Center(
                  child:
                      Text("Continue", style: context.textTheme.bodyLarge?.copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't received code? ",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
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
                    style: TextStyle(color: Color(0xffFF9C00), fontWeight: FontWeight.w500, fontSize: 13),
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
