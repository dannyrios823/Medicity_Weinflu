import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';
import 'package:reto_weinflu/utils/validate_helper.dart';
import 'package:reto_weinflu/utils/list_medicines.dart';
import 'package:reto_weinflu/utils/persons.dart';
import 'package:reto_weinflu/widgets/data_table.dart';
import 'package:reto_weinflu/widgets/time_picker_medicine.dart';

class FormMedicine extends StatefulWidget {
  final MaterialColor selectedColor;
  
  const FormMedicine({super.key, required this.selectedColor});
  
  @override
  State<FormMedicine> createState() => _FormMedicineState();
}

class _FormMedicineState extends State<FormMedicine> {
  List<Persons> personsLst = <Persons>[];
  final formKey = GlobalKey<FormState>();
  String medicinas = '';
  String pickerTime = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDropdownValue = ListMocks.listaDeOpciones.first;
  final ValueNotifier<String> timePickerButtonController = ValueNotifier<String>(RetoCopys.emptyHour);

  @override
  void initState() {
    super.initState();
    medicinas = '';
    pickerTime = '';
  }
  
  void refreshList() {
    personsLst.sort();
    setState(() {});
  }
  
  void validate() {
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
                      enabledBorder: const UnderlineInputBorder(),   
                      focusedBorder: const UnderlineInputBorder(),
                    ),
                    value: selectedDropdownValue,
                    items: ListMocks.listaDeOpciones.map((name) {
                      return DropdownMenuItem(
                        value: name,
                        enabled: name != ListMocks.listaDeOpciones.first,
                        child: Text(
                          
                          name, style: name != ListMocks.listaDeOpciones.first
                              ? const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)  // Estilo para el valor seleccionado
                              
                              : const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDropdownValue = value ?? ListMocks.listaDeOpciones.first;
                        medicinas = selectedDropdownValue;  // Actualizamos el valor de medicinas según la selección
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
      ],
    );
  }
}