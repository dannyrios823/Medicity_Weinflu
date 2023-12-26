import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';
import 'package:reto_weinflu/utils/paths.dart';
import 'package:reto_weinflu/widgets/form_medicines.dart';
import 'package:reto_weinflu/widgets/dropdown_color.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});
  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  MaterialColor selectedColor = Colors.red;

  Map<MaterialColor, String> colorImageMap = {
    Colors.red: RetoPaths.redImage,
    Colors.blue: RetoPaths.blueImage,
    Colors.green: RetoPaths.greenImage,
    Colors.purple: RetoPaths.purpleImage,
  };

  @override
  Widget build(BuildContext context) {
    String selectedImage = colorImageMap[selectedColor] ?? RetoPaths.redImage;
    return ColorProvider(
      selectedColor: selectedColor,
      onColorChanged: (MaterialColor color) {
        setState(() {
          selectedColor = color;
        });
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: ColorsMedicine.whiteColor,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      RetoCopys.medicine, style: TextStyle(
                        color: ColorsMedicine.whiteColor
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 12),
                    child: Image.asset(selectedImage),
                  ),
                  DropdownColor(
                    onColorChanged: (MaterialColor color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: selectedColor,
          ),
          body: FormMedicine(selectedColor: selectedColor),
        ),
      ),
    );
  }
}