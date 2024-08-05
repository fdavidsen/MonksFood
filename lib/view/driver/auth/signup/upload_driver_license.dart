import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monk_food/model/driver_model.dart';
import 'dart:io';

import 'package:monk_food/view/driver/auth/signup/upload_certificate.dart';

class DriverLicenseUpload extends StatefulWidget {
  final Driver driver;
  const DriverLicenseUpload({super.key, required this.driver});

  @override
  _DriverLicenseUploadState createState() => _DriverLicenseUploadState();
}

class _DriverLicenseUploadState extends State<DriverLicenseUpload> {
  File? _driverLicenseFrontPicture;
  File? _driverLicenseBackPicture;
  final ImagePicker _picker = ImagePicker();
  String _errorMessage = '';

  Future<void> _pickFrontImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _driverLicenseFrontPicture = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickBackImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _driverLicenseBackPicture = File(pickedFile.path);
      });
    }
  }

  Future<void> _next() async {
    if (_driverLicenseFrontPicture != null && _driverLicenseBackPicture != null) {
      widget.driver.driverLicenseFront = _driverLicenseFrontPicture?.path;
      widget.driver.driverLicenseBack = _driverLicenseBackPicture?.path;
      print(widget.driver);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CertificateUpload(driver: widget.driver)),
      );
    } else {
      setState(() {
        _errorMessage = 'Please upload both the front and back of your driver license';
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
                  "Upload Driver License",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Driver License - FRONT",
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: _pickFrontImage,
                    child: _driverLicenseFrontPicture != null
                        ? Image.file(
                            _driverLicenseFrontPicture!,
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                const SizedBox(height: 20),
                const Text(
                  "Driver License - BACK",
                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: _pickBackImage,
                    child: _driverLicenseBackPicture != null
                        ? Image.file(
                            _driverLicenseBackPicture!,
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                          )
                        : Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                  "Driver License Requirements:",
                  style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 12),
                  child: Text(
                    "1. One photo of the front and one of the back, with all information clearly readable.",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "2. The entire document must be fully visible in the photo.",
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
