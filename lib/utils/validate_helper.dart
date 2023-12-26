import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';

class FormValidationHelper {
  final MaterialColor selectedColor;
  
  const FormValidationHelper({required this.selectedColor});
  
  static void validateAndHandleErrors({
    required BuildContext context,
    required String medicinas,
    required String pickerTime,
    required GlobalKey<FormState> formKey,
    required VoidCallback onValidated,
  }) {
    if (medicinas.isEmpty) {
      print('Te falta la medicina');
      showErrorDialog(context, RetoCopys.errorMedicine);
    } 
    else if (pickerTime.isEmpty) {
      print('Te falta la hora');
      showErrorDialog(context, RetoCopys.errorHour);
    }
    else if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onValidated();
    }
  }

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