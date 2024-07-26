import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:monk_food/model/customer_handler.dart';
import 'package:monk_food/view/customer/auth/otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;

      final emailExists = await CustomerHandler().isEmailExisted(email);
      if (emailExists) {
        await EmailOTP.sendOTP(email: email);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(email: email),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email does not exist')));
      }
    }
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
                const Hero(
                  tag: Key("fp"),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please enter your Email so we can help you recover your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                ),
                const SizedBox(height: 140),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: _sendOTP,
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
