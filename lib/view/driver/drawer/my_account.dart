import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monk_food/controller/driver_auth_provider.dart';
import 'package:monk_food/model/query/driver_handler.dart';
import 'package:monk_food/model/driver_model.dart';
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
  String _errorMessage = '';

  late Driver driver;
  late Future<void> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUserData();
  }

  Future<void> _loadUserData() async {
    final driverAuthProvider = Provider.of<DriverAuthProvider>(context, listen: false);
    if (driverAuthProvider.user != null) {
      driver = driverAuthProvider.user!;
      _usernameController.text = driver.username;
      _emailController.text = driver.email;
      _phoneController.text = driver.phone;
      _passwordController.text = driver.password;
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (_usernameController.text != driver.username) {
        bool isUsernameUnique = await DriverHandler().isUsernameUnique(_usernameController.text);
        if (!isUsernameUnique) {
          setState(() {
            _errorMessage = 'Username already exists';
          });
          return;
        }
      }

      if (_emailController.text != driver.email) {
        bool isEmailExisted = await DriverHandler().isEmailExisted(_emailController.text);
        if (isEmailExisted) {
          setState(() {
            _errorMessage = 'Email already exists';
          });
          return;
        }
      }

      final updatedDriver = Driver(
        id: driver.id,
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        bankId: driver.bankId,
        bankFirstName: driver.bankFirstName,
        bankLastName: driver.bankLastName,
        bankPhone: driver.bankPhone,
        profilePicture: driver.profilePicture,
        certificate: driver.certificate,
        driverLicenseFront: driver.driverLicenseFront,
        driverLicenseBack: driver.driverLicenseBack,
      );

      driver = updatedDriver;
      await DriverHandler().updateDriverData(updatedDriver);
      Provider.of<DriverAuthProvider>(context, listen: false).setUser(updatedDriver);
      Provider.of<DriverEditController>(context, listen: false).changeMode();
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
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const Text(
                        "My Account",
                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Image.file(
                          File(driver.profilePicture!),
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (Provider.of<DriverEditController>(context, listen: false).isEditing) {
                                _updateUserData();
                              } else {
                                Provider.of<DriverEditController>(context, listen: false).changeMode();
                              }
                              setState(() {
                                _errorMessage = '';
                              });
                            },
                            icon: Icon(
                              Provider.of<DriverEditController>(context).isEditing ? Icons.check : Icons.edit,
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
                          enabled: Provider.of<DriverEditController>(context).isEditing,
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
                          enabled: Provider.of<DriverEditController>(context).isEditing,
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
                          enabled: Provider.of<DriverEditController>(context).isEditing,
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
                          enabled: Provider.of<DriverEditController>(context).isEditing,
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

class DriverEditController extends ChangeNotifier {
  bool isEditing = false;

  void changeMode() {
    isEditing = !isEditing;
    notifyListeners();
  }
}
