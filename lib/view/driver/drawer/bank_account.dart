import 'package:flutter/material.dart';
import 'package:monk_food/controller/driver_auth_provider.dart';
import 'package:monk_food/model/driver_model.dart';
import 'package:monk_food/model/query/driver_handler.dart';
import 'package:provider/provider.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  _BankAccountPageState createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _bankIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

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
      _bankIdController.text = driver.bankId ?? '';
      _firstNameController.text = driver.bankFirstName ?? '';
      _lastNameController.text = driver.bankLastName ?? '';
      _phoneController.text = driver.bankPhone ?? '';
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      final updatedDriver = Driver(
        id: driver.id,
        username: driver.username,
        email: driver.email,
        phone: driver.phone,
        password: driver.password,
        bankId: _bankIdController.text,
        bankFirstName: _firstNameController.text,
        bankLastName: _lastNameController.text,
        bankPhone: _phoneController.text,
        profilePicture: driver.profilePicture,
        certificate: driver.certificate,
        driverLicenseFront: driver.driverLicenseFront,
        driverLicenseBack: driver.driverLicenseBack,
      );

      driver = updatedDriver;
      await DriverHandler().updateDriverData(updatedDriver);
      Provider.of<DriverAuthProvider>(context, listen: false).setUser(updatedDriver);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update successful')));
      Navigator.of(context).pop();
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
                        "Bank Account",
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
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _bankIdController,
                        decoration: const InputDecoration(
                          labelText: 'Bank ID',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
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
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
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
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
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
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: _updateUserData,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCD5638),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                            child: const Text(
                              'Save & Back',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
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
