import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius,
    this.width = double.infinity,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {/* controller.onValidated(), */ onPressed?.call()},
      child: Container(
        height: height ?? 42,
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        child: Center(
          child: Text(
            text ?? 'Vaider',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
