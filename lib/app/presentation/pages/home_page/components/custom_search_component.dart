import 'package:flutter/material.dart';

class CustomSearchComponent extends StatelessWidget {
  const CustomSearchComponent({
    super.key,
    required TextEditingController textEditingController,
    required this.hintText,
    this.iconData,
  }) : _usernameTextController = textEditingController;

  final TextEditingController _usernameTextController;
  final String hintText;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _usernameTextController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          suffixIcon: Icon(iconData ?? Icons.search,
              color: Colors.grey.shade600, size: 20),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
