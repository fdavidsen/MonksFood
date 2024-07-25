class Customer {
  int id;
  String username;
  String email;
  String phone;
  String password;

  Customer({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Customer(id: $id, username: $username, email: $email, phone: $phone, password: $password)';
  }
}
