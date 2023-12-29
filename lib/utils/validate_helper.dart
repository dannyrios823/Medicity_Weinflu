import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/error_dialog.dart';

class FormValidationHelper {
  static void validateAndHandleErrors({
    required BuildContext context,
    required String medicinas,
    required String pickerTime,
    required GlobalKey<FormState> formKey,
    required VoidCallback onValidated,
  }) {
    if (medicinas.isEmpty) {
      print('Te falta la medicina');
      ErrorDialog.showErrorDialog(context, RetoCopys.errorMedicine);
    } 
    else if (pickerTime.isEmpty) {
      print('Te falta la hora');
      ErrorDialog.showErrorDialog(context, RetoCopys.errorHour);
    }
    else if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onValidated();
    }
  }
}