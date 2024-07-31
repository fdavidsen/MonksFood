import 'package:flutter/material.dart';
import 'package:monk_food/view/customer/auth/reset_password.dart';
import 'package:email_otp/email_otp.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      bool isValid = EmailOTP.verifyOTP(otp: _otpController.text);
      if (isValid) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid or expired OTP')));
      }
    }
  }

  void _resendOtp() async {
    await EmailOTP.sendOTP(email: widget.email);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP has been sent to your email')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  "Verification",
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                ),
                const SizedBox(height: 100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "OTP",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                      labelText: 'OTP',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter the OTP code from the email we just sent you",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn’t receive the OTP code ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                    ),
                    TextButton(
                      onPressed: _resendOtp,
                      style: TextButton.styleFrom(foregroundColor: const Color(0xFFCD5638)),
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 140),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: _verifyOTP,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCD5638),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
