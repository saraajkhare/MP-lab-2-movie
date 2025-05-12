// review.dart
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  final String name, surname, dob, address, email, phone, gender, review;
  final double rating;

  const ReviewPage({
    super.key,
    required this.name,
    required this.surname,
    required this.dob,
    required this.address,
    required this.email,
    required this.phone,
    required this.gender,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Review Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text("Name: $name", style: const TextStyle(fontSize: 18)),
                  Text("Surname: $surname",
                      style: const TextStyle(fontSize: 18)),
                  Text("Date of Birth: $dob",
                      style: const TextStyle(fontSize: 18)),
                  Text("Address: $address",
                      style: const TextStyle(fontSize: 18)),
                  Text("Email: $email", style: const TextStyle(fontSize: 18)),
                  Text("Phone: $phone", style: const TextStyle(fontSize: 18)),
                  Text("Gender: $gender", style: const TextStyle(fontSize: 18)),
                  Text("Review: $review", style: const TextStyle(fontSize: 18)),
                  Text("Rating: $rating", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
