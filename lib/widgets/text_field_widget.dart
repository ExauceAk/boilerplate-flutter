import 'package:flutter/material.dart';


Widget buildTextField(TextEditingController fieldController, String label,
    {bool isPassword = false}) {
  return SizedBox(
    height: 42,
    child: TextField(
      obscureText: isPassword,
      controller: fieldController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}