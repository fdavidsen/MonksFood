import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:monk_food/model/query/driver_handler.dart';
import 'package:monk_food/model/driver_model.dart';
import 'package:monk_food/view/driver/auth/signup/registration_received.dart';

class SetBankAccountScreen extends StatefulWidget {
  final Driver driver;
  const SetBankAccountScreen({super.key, required this.driver});

  @override
  _SetBankAccountScreenState createState() => _SetBankAccountScreenState();
}

class _SetBankAccountScreenState extends State<SetBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bankIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      widget.driver.bankId = _bankIdController.text;
      widget.driver.bankFirstName = _firstNameController.text;
      widget.driver.bankLastName = _lastNameController.text;
      widget.driver.bankPhone = _phoneController.text;

      bool isValid = EmailOTP.verifyOTP(otp: _verificationController.text);
      if (isValid) {
        await DriverHandler().register(widget.driver.toMap());
        print(widget.driver);

        _bankIdController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        _verificationController.clear();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful')));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationReceivedScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid or expired OTP')));
      }
    }
  }

  void _requestOtp() async {
    await EmailOTP.sendOTP(email: widget.driver.email);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Setting Up a Bank Account",
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Bank ID",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _bankIdController,
                  decoration: const InputDecoration(
                      labelText: 'Bank ID',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Bank ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      labelText: 'First Name',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Last Name",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      labelText: 'Last Name',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      // Example: simple phone number validation
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Verification",
                      style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _verificationController,
                  decoration: const InputDecoration(
                      labelText: 'Verification',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                  validator: (value) {
                    if (value != _verificationController.text) {
                      return 'Verification failed, invalid or expired OTP';
                    }
                    return null;
                  },
                ),
                Wrap(
                  children: [
                    TextButton(
                      onPressed: _requestOtp,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Click here',
                        style: TextStyle(
                            decoration: TextDecoration.underline, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: Text(
                        " to receive the OTP number.",
                        style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: _requestOtp,
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                            decoration: TextDecoration.underline, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCD5638),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
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
