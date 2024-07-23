import 'dart:math';
import 'package:monks_food/database/otp_handler.dart';
import 'package:monks_food/models/otp_model.dart';

class OTPService {
  final OTPHandler _otpHandler = OTPHandler();

  String _generateOTP() {
    var rng = Random();
    return (rng.nextInt(900000) + 100000).toString(); // Generates a 6-digit OTP
  }

  Future<void> sendOTP(String email) async {
    String otp = _generateOTP();
    DateTime now = DateTime.now();
    OTP otpModel = OTP(email: email, otp: otp, createdAt: now);

    await _otpHandler.insertOTP(otpModel);

    // Send OTP via email
    sendEmail(email, 'Your OTP Code', 'Your OTP code is $otp');
  }

  Future<bool> verifyOTP(String email, String otp) async {
    OTP? otpModel = await _otpHandler.getOTP(email, otp);
    if (otpModel != null) {
      Duration difference = DateTime.now().difference(otpModel.createdAt);
      if (difference.inMinutes <= 5) {
        await _otpHandler.deleteOTP(otpModel.id!);
        return true;
      }
    }
    return false;
  }

  Future<void> sendEmail(String to, String subject, String body) async {
    // Implement your email sending logic here
    print('Sending email to $to: $subject - $body');
  }
}
