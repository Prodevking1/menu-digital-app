import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final String? value;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final double? height;
  final String? borderCol;
  final double? borderRadius;
  final Color? backgroundColor;

  CustomDropdown({
    Key? key,
    this.hintText,
    this.icon,
    required this.items,
    this.value,
    this.onChanged,
    this.height,
    this.borderCol,
    this.borderRadius,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 42,
      child: DropdownButtonFormField<String>(
        value: widget.value,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          widget.onChanged?.call(value!);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    widget.icon,
                    color: Colors.black,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          fillColor: widget.backgroundColor ?? Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
