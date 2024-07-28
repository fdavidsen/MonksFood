import 'package:flutter/material.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/model/customer_handler.dart';
import 'package:monk_food/model/customer_model.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  late Customer customer;
  late Future<void> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUserData();
  }

  Future<void> _loadUserData() async {
    final customerAuthProvider = Provider.of<CustomerAuthProvider>(context, listen: false);
    if (customerAuthProvider.user != null) {
      customer = customerAuthProvider.user!;
      _usernameController.text = customer.username;
      _emailController.text = customer.email;
      _phoneController.text = customer.phone;
      _passwordController.text = customer.password;
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      final updatedCustomer = Customer(
        id: customer.id,
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );

      await CustomerHandler().updateCustomer(updatedCustomer);
      Provider.of<CustomerAuthProvider>(context, listen: false).setUser(updatedCustomer);
      Provider.of<EditController>(context, listen: false).changeMode();
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
      body: FutureBuilder<void>(
        future: _loadUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "My Account",
                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<EditController>(context, listen: false).changeMode();
                            },
                            icon: Icon(
                              Provider.of<EditController>(context).isEditing ? Icons.check : Icons.edit,
                              color: const Color(0xFFCD5638),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                          enabled: Provider.of<EditController>(context).isEditing,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                          enabled: Provider.of<EditController>(context).isEditing,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
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
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                          enabled: Provider.of<EditController>(context).isEditing,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
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
                            "Password",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                          enabled: Provider.of<EditController>(context).isEditing,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class EditController extends ChangeNotifier {
  bool isEditing = false;

  void changeMode() {
    isEditing = !isEditing;
    notifyListeners();
  }
}
