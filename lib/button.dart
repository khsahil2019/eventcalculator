import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  GradientElevatedButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity, // Make button full-width
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.teal, Colors.blueAccent], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent background
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Match container corners
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
