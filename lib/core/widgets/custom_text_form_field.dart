import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    this.maxLines,
    required this.title,
    this.validator,
    required this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final String title;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 8),
        TextFormField(
          validator:
              validator != null ? (String? val) => validator!(val) : null,
          maxLines: maxLines,
          cursorColor: Theme.of(context).textTheme.labelMedium?.color,

          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
