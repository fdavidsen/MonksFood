class OTP {
  final int? id;
  final String email;
  final String otp;
  final DateTime createdAt;

  OTP({
    this.id,
    required this.email,
    required this.otp,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'otp': otp,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OTP.fromMap(Map<String, dynamic> map) {
    return OTP(
      id: map['id'],
      email: map['email'],
      otp: map['otp'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
