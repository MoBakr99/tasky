import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String fieldTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final int maxLines;
  final bool? autofocus;
  final bool border;

  const CustomFormField(
      {super.key,
      required this.fieldTitle,
      this.controller,
      this.validator,
      this.hintText,
      this.maxLines = 1,
      this.autofocus,
      this.border = false});

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
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(maxLines > 1 ? 20 : 16)),
              borderSide: border
                  ? const BorderSide(width: 0.5, color: Color(0xFF6E6E6E))
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(maxLines > 1 ? 20 : 16)),
              borderSide: border
                  ? const BorderSide(width: 0.5, color: Color(0xFF6E6E6E))
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(maxLines > 1 ? 20 : 16)),
              borderSide: border
                  ? const BorderSide(
                      width: 1,
                      color: Color(
                          0xFF6E6E6E)) // Example: thicker border when focused
                  : BorderSide.none,
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
