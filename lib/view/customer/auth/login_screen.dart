import 'package:flutter/material.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/model/customer_handler.dart';
import 'package:monk_food/view/customer/auth/forgot_password_screen.dart';
import 'package:monk_food/view/customer/auth/signup_screen.dart';
import 'package:monk_food/view/customer/home.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = await CustomerHandler().login(username, password);
      if (user != null) {
        print(user);
        await saveLoginState(true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful')));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // Login failed, show error message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Sign In",
                    style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                  ),
                  const SizedBox(
                    height: 30,
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
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638)))),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Hero(
                        tag: const Key("fp"),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(decoration: TextDecoration.underline, color: Color(0xFF727171), fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCD5638),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You don't have an account?",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style:
                          TextStyle(decoration: TextDecoration.underline, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
