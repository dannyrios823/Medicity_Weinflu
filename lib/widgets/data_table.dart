import 'package:flutter/material.dart';
import 'package:reto_weinflu/design/colors.dart';
import 'package:reto_weinflu/design/copys.dart';
import 'package:reto_weinflu/utils/color_provider.dart';
import 'package:reto_weinflu/utils/persons.dart';

class DataTableWidget extends StatelessWidget {
  final List<Persons> personsLst;
  final Function(int) onDelete;
  final MaterialColor selectedColor;

  const DataTableWidget(
      {Key? key, required this.personsLst, required this.onDelete, required this.selectedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = ColorProvider.of(context)!;
    MaterialColor selectedColor = colorProvider.selectedColor;
    return SingleChildScrollView(
      child: Center(
        child: personsLst.isEmpty
        ? const Text(RetoCopys.emptyList)
        : DataTable(
          columns: [
            if (personsLst.isNotEmpty)
            const DataColumn(
              label: Text(
                RetoCopys.titleTableMed,
                style: TextStyle(
                    color: ColorsMedicine.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (personsLst.isNotEmpty)
            const DataColumn(
              label: Text(
                RetoCopys.titleTableHour,
                style: TextStyle(
                    color: ColorsMedicine.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (personsLst.isNotEmpty)
            const DataColumn(
              label: Text(
                RetoCopys.titleDelete,
                style: TextStyle(
                    color: ColorsMedicine.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: personsLst.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final person = entry.value;
              return DataRow(cells: [
                DataCell(
                  Center(child: Text(person.medicina)),
                ),
                DataCell(
                  Center(child: Text(person.timer)),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete, color: selectedColor),
                    onPressed: () {
                      onDelete(index);
                    },
                  ),
                ),
              ]);
            },
          ).toList(),
        ),
      ),
    );
  }
}