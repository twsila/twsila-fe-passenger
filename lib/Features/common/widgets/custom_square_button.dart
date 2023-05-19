import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';

class CustomSquareButton extends StatefulWidget {
  final Function() onPressed;
  final IconData iconData;
  final String text;
  final double? height;
  final double? width;

  const CustomSquareButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.iconData,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<CustomSquareButton> createState() => _CustomSquareButtonState();
}

class _CustomSquareButtonState extends State<CustomSquareButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width ?? context.getWidth() / 3,
        height: widget.height ?? 120,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.iconData,
                size: 32,
                color: Colors.white,
              ),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
