import 'package:flutter/material.dart';

class ColorProvider extends InheritedWidget {
  final MaterialColor selectedColor;
  final Function(MaterialColor) onColorChanged;

  const ColorProvider({
    required this.selectedColor,
    required this.onColorChanged,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static ColorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorProvider>();
  }

  @override
  bool updateShouldNotify(ColorProvider oldWidget) {
    return selectedColor != oldWidget.selectedColor;
  }
}