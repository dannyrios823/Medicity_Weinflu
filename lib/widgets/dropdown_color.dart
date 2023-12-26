import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';

class DropdownColor extends StatefulWidget {
  final void Function(MaterialColor) onColorChanged;
  const DropdownColor({required this.onColorChanged, Key? key}) : super(key: key);

  @override
  State<DropdownColor> createState() => _DropdownColorState();
}

class _DropdownColorState extends State<DropdownColor> {
  MaterialColor selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsMedicine.whiteColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: ColorsMedicine.blackColor
        ),
      ),
      child: DropdownButton<MaterialColor>(
        value: selectedColor,
        onChanged: (MaterialColor? newValue) {
          if (newValue != null) {
            setState(() {
              selectedColor = newValue;
            });
            widget.onColorChanged(selectedColor);
          }
        },
        items: const <DropdownMenuItem<MaterialColor>>[
          DropdownMenuItem(
            value: Colors.red,
            child: Icon(Icons.format_color_fill, color: ColorsMedicine.redColor),
          ),
          DropdownMenuItem(
            value: Colors.blue,
            child: Icon(Icons.format_color_fill, color: ColorsMedicine.blueColor),
          ),
          DropdownMenuItem(
            value: Colors.green,
            child: Icon(Icons.format_color_fill, color: ColorsMedicine.greenColor),
          ),
          DropdownMenuItem(
            value: Colors.purple,
            child: Icon(Icons.format_color_fill, color: ColorsMedicine.purpleColor),
          ),
        ],
      ),
    );
  }
}