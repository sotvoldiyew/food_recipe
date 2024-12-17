import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

class MyTextFild extends StatelessWidget {
  const MyTextFild({
    super.key,
    required this.controller,
    required this.labelName,
    this.validator,
  });

  final TextEditingController controller;
  final String labelName;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: context.textTheme.titleMedium?.copyWith(
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: context.colors.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colors.primary,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
