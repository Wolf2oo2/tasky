import 'package:flutter/material.dart';
class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    required this.value,
    required this.onChanged,
    super.key});
final bool value;
final Function(bool?)onChanged;
  @override
  Widget build(BuildContext context) {
    return  Checkbox(
      value: value,
      onChanged: (bool? val) =>onChanged(val),
      activeColor: Color(0xff15B86C),
    ) ;
  }
}
