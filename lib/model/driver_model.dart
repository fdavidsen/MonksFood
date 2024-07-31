class Driver {
  int? id;
  String username;
  String email;
  String phone;
  String password;
  String? profilePicture;
  String? driverLicenseFront;
  String? driverLicenseBack;
  String? certificate;
  String? bankId;
  String? bankFirstName;
  String? bankLastName;
  String? bankPhone;

  Driver({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    this.id,
    this.profilePicture,
    this.driverLicenseFront,
    this.driverLicenseBack,
    this.certificate,
    this.bankId,
    this.bankFirstName,
    this.bankLastName,
    this.bankPhone,
  });

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      profilePicture: map['profilePicture'],
      driverLicenseFront: map['driverLicenseFront'],
      driverLicenseBack: map['driverLicenseBack'],
      certificate: map['certificate'],
      bankId: map['bankId'],
      bankFirstName: map['bankFirstName'],
      bankLastName: map['bankLastName'],
      bankPhone: map['bankPhone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'profilePicture': profilePicture,
      'driverLicenseFront': driverLicenseFront,
      'driverLicenseBack': driverLicenseBack,
      'certificate': certificate,
      'bankId': bankId,
      'bankFirstName': bankFirstName,
      'bankLastName': bankLastName,
      'bankPhone': bankPhone,
    };
  }

  @override
  String toString() {
    return 'Driver(id: $id, username: $username, email: $email, phone: $phone, password: $password, bankId: $bankId, bankFirstName: $bankFirstName, bankLastName: $bankLastName, bankPhone: $bankPhone)';
  }
}
