import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monk_food/model/driver_model.dart';
import 'dart:io';

import 'package:monk_food/view/driver/auth/signup/upload_driver_license.dart';

class ProfilePictureUpload extends StatefulWidget {
  final Driver driver;
  const ProfilePictureUpload({super.key, required this.driver});

  @override
  _ProfilePictureUploadState createState() => _ProfilePictureUploadState();
}

class _ProfilePictureUploadState extends State<ProfilePictureUpload> {
  File? _profilePicture;
  final ImagePicker _picker = ImagePicker();
  String _errorMessage = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  Future<void> _next() async {
    if (_profilePicture != null) {
      widget.driver.profilePicture = _profilePicture?.path;
      print(widget.driver);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DriverLicenseUpload(driver: widget.driver)),
      );
    } else {
      setState(() {
        _errorMessage = 'Please upload your profile picture';
      });
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Profile Picture",
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: _profilePicture != null
                        ? Image.file(
                            _profilePicture!,
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.red, // Red border color
                                width: 1, // Border width
                              ),
                            ),
                            child: const Icon(Icons.add, size: 50),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                const Text(
                  "Picture Requirements:",
                  style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 12),
                  child: Text(
                    "1. The entire face and top of the shoulders must be clearly visible.",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "2. Do not wear sunglasses or hats.",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "3. Please provide a picture taken in a well-lit environment.",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Customers will use this picture to identify you. A friendly and approachable picture will leave a good impression on customers.",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCD5638),
                            foregroundColor: const Color.fromARGB(255, 219, 191, 191),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 20),
                        ),
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
