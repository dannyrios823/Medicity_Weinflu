import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';

class TimePickerMedicine extends StatefulWidget{
  final Function(String) onTimeSelected;
  final ValueNotifier<String> buttonController;

  const TimePickerMedicine({required this.onTimeSelected, required this.buttonController, Key? key}) : super(key: key);

  @override
  State<TimePickerMedicine> createState() => _TimePickerMedicineState();
}

class _TimePickerMedicineState extends State<TimePickerMedicine>{
  TimeOfDay selectedTime = TimeOfDay.now();
  String horaPicker = '';
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = ColorProvider.of(context)!;
    MaterialColor selectedColor = colorProvider.selectedColor;
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Text(RetoCopys.hourMedicine, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorsMedicine.whiteColor,
              backgroundColor: selectedColor,
            ),
            child: Text(
              widget.buttonController.value.isEmpty ? RetoCopys.emptyHour : widget.buttonController.value,
              style: const TextStyle(fontSize: 20),
            ),
            onPressed: () async{    
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context, 
                initialTime: selectedTime,
                initialEntryMode: TimePickerEntryMode.dial, 
              );
              if(timeOfDay != null){
                setState(() {
                  selectedTime = timeOfDay;
                  horaPicker = "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}";
                });
                widget.buttonController.value = horaPicker;
                widget.onTimeSelected(horaPicker);
              }
            },
          ),
        ],
      ),
    );
  }
}