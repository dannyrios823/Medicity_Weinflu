import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';

class ErrorDialog {
  final MaterialColor selectedColor;
  
  const ErrorDialog({required this.selectedColor});
  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorProvider colorProvider = ColorProvider.of(context)!;
        MaterialColor selectedColor = colorProvider.selectedColor;
        return AlertDialog(
          title: const Text(RetoCopys.titlePopUp),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text(
                RetoCopys.buttonPopUp, 
                style: TextStyle(color: selectedColor)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}