import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final Color? color;
  final double? height;
  const CustomTextButton({
    Key? key,
    this.color,
    this.height,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height ?? 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(widget.text),
      ),
    );
  }
}
