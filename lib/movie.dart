// movie.dart
import 'package:flutter/material.dart';
import 'review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  String _gender = "Male";
  double _rating = 1.0;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter your email";
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
    if (!RegExp(emailPattern).hasMatch(value)) return "Enter a valid email";
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Enter your phone number";
    String phonePattern = r'^\d{10}$';
    if (!RegExp(phonePattern).hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit Movie Review")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text("Movie Review Form",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildTextField("Name", _nameController),
                  _buildTextField("Surname", _surnameController),
                  _buildTextField("Date of Birth", _dobController),
                  _buildTextField("Address", _addressController),
                  _buildTextField("Email ID", _emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress),
                  _buildTextField("Phone Number", _phoneController,
                      validator: _validatePhone,
                      keyboardType: TextInputType.phone),
                  DropdownButtonFormField(
                    value: _gender,
                    decoration: const InputDecoration(
                        labelText: "Gender", border: OutlineInputBorder()),
                    items: ["Male", "Female", "Other"].map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildTextField("Review", _reviewController),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 1.0,
                    minRating: 1.0,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review Submitted"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewPage(
                              name: _nameController.text,
                              surname: _surnameController.text,
                              dob: _dobController.text,
                              address: _addressController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              gender: _gender,
                              review: _reviewController.text,
                              rating: _rating,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator:
            validator ?? (value) => value!.isEmpty ? "Enter $label" : null,
        keyboardType: keyboardType,
      ),
    );
  }
}
