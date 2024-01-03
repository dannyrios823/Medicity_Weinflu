import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';
import 'package:reto_weinflu/utils/error_dialog.dart';
import 'package:reto_weinflu/utils/validate_helper.dart';
import 'package:reto_weinflu/utils/list_medicines.dart';
import 'package:reto_weinflu/utils/persons.dart';
import 'package:reto_weinflu/widgets/data_table.dart';
import 'package:reto_weinflu/widgets/time_picker_medicine.dart';
import 'package:reto_weinflu/widgets/rotating_square.dart';

class FormMedicine extends StatefulWidget {
  final MaterialColor selectedColor;
  
  const FormMedicine({super.key, required this.selectedColor});
  
  @override
  State<FormMedicine> createState() => _FormMedicineState();
}

class _FormMedicineState extends State<FormMedicine> with SingleTickerProviderStateMixin {
  List<Persons> personsLst = <Persons>[];
  final formKey = GlobalKey<FormState>();
  String medicinas = '';
  String pickerTime = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDropdownValue = ListMocks.listaDeOpciones.first;
  final ValueNotifier<String> timePickerButtonController = ValueNotifier<String>(RetoCopys.emptyHour);
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    medicinas = '';
    pickerTime = '';
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1415).animate(_controller);
  }
  
  void refreshList() {
    personsLst.sort();
    setState(() {});
  }
  
  void validate() {
    if (personsLst.any((person) => person.medicina == medicinas && person.timer == pickerTime)) {
      ErrorDialog.showErrorDialog(context, RetoCopys.errorDuplicate);
      return;
    }
    FormValidationHelper.validateAndHandleErrors(
      context: context,
      medicinas: medicinas,
      pickerTime: pickerTime,
      formKey: formKey,
      onValidated: () {
        String dropMed = medicinas;
        String tm = pickerTime;
        Persons p = Persons(dropMed, tm);
        personsLst.add(p);
        refreshList();
        setState(() {
          medicinas = '';
          pickerTime = '';
          selectedDropdownValue = ListMocks.listaDeOpciones.first;
          timePickerButtonController.value = RetoCopys.emptyHour;
        });
      },
    );
  }

  void onDelete(int index) {
    setState(() {
      personsLst.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = ColorProvider.of(context)!;
    MaterialColor selectedColor = colorProvider.selectedColor;
    return ListView(
      children: <Widget>[
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorsMedicine.blackColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: RetoCopys.selectMedicine,
                      labelStyle: TextStyle(color: selectedColor),
                      icon: Icon(Icons.menu, color: selectedColor),
                      enabledBorder: InputBorder.none,   
                      focusedBorder: InputBorder.none,
                    ),
                    value: selectedDropdownValue,
                    items: ListMocks.listaDeOpciones.map((name) {
                      return DropdownMenuItem(
                        value: name,
                        enabled: name != ListMocks.listaDeOpciones.first,
                        child: Text(
                          name, style: name != ListMocks.listaDeOpciones.first
                              ? const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
                              : const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDropdownValue = value ?? ListMocks.listaDeOpciones.first;
                        medicinas = selectedDropdownValue;
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TimePickerMedicine(
                        onTimeSelected: (horaPicker) {
                          setState(() {
                            pickerTime = horaPicker;
                          });
                        },
                        buttonController: timePickerButtonController,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      padding: const EdgeInsets.all(15),
                      child: FloatingActionButton(
                        onPressed: validate,
                        shape: const CircleBorder(),
                        backgroundColor: selectedColor,
                        child: const Icon(Icons.add, color: ColorsMedicine.whiteColor),
                      ), 
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
        DataTableWidget(personsLst: personsLst, onDelete: onDelete, selectedColor: selectedColor),
        const SizedBox(height: 20),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatingSquare(rotationAnimation: _rotationAnimation, selectedColor: selectedColor),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(5),
                child: FloatingActionButton(
                  onPressed: () {
                    if (_controller.status == AnimationStatus.completed) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  shape: const CircleBorder(),
                  backgroundColor: selectedColor,
                  child: const Icon(Icons.autorenew, color: ColorsMedicine.whiteColor),
                ), 
              ),
            ],
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}