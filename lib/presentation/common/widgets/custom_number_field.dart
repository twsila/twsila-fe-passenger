import 'package:flutter/material.dart';

import 'custom_text_input_field.dart';

class CustomNumberField extends StatefulWidget {
  int? customValue;
  String text;
  CustomNumberField({
    Key? key,
    required this.customValue,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomNumberField> createState() => _CustomNumberFieldState();
}

class _CustomNumberFieldState extends State<CustomNumberField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 45,
          child: CustomTextInputField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value == '') {
                widget.customValue = null;
                return;
              }
              widget.customValue = int.parse(value);
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
