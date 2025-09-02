import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String fieldTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final int maxLines;
  final bool? autofocus;

  const CustomFormField(
      {super.key,
      required this.fieldTitle,
      this.controller,
      this.validator,
      this.hintText,
      this.maxLines = 1,
      this.autofocus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          autofocus: autofocus ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            fillColor: const Color(0xFF282828),
            hintStyle: const TextStyle(color: Color(0xff6D6D6D), fontSize: 16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
