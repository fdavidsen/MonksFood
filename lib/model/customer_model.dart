class Customer {
  int id;
  String username;
  String email;
  String phone;
  String password;
  String? cardFirstName;
  String? cardLastName;
  String? cardNumber;
  String? expirationDate;
  String? cvv;

  Customer({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    this.cardFirstName,
    this.cardLastName,
    this.cardNumber,
    this.expirationDate,
    this.cvv,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      cardFirstName: map['card_first_name'],
      cardLastName: map['card_last_name'],
      cardNumber: map['card_number'],
      expirationDate: map['expiration_date'],
      cvv: map['cvv'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'card_first_name': cardFirstName,
      'card_last_name': cardLastName,
      'card_number': cardNumber,
      'expiration_date': expirationDate,
      'cvv': cvv,
    };
  }

  @override
  String toString() {
    return 'Customer(id: $id, username: $username, email: $email, phone: $phone, password: $password, cardFirstName: $cardFirstName, cardLastName: $cardLastName, cardNumber: $cardNumber, expirationDate: $expirationDate, cvv: $cvv)';
  }
}
