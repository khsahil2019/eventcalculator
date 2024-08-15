// lib/widgets/equipment_selection_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EquipmentSelectionWidget extends StatefulWidget {
  final List<String> equipmentOptions;
  final Map<String, int> selectedEquipment;

  EquipmentSelectionWidget({
    required this.equipmentOptions,
    required this.selectedEquipment,
  });

  @override
  _EquipmentSelectionWidgetState createState() =>
      _EquipmentSelectionWidgetState();
}

class _EquipmentSelectionWidgetState extends State<EquipmentSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.equipmentOptions.map((equipment) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.selectedEquipment.containsKey(equipment),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            widget.selectedEquipment[equipment] = 1;
                          } else {
                            widget.selectedEquipment.remove(equipment);
                          }
                        });
                      },
                    ),
                    Text(equipment),
                  ],
                ),
                if (widget.selectedEquipment.containsKey(equipment))
                  SizedBox(
                    width: 50,
                    height: 40,
                    child: TextFormField(
                      initialValue:
                          widget.selectedEquipment[equipment].toString(),
                      decoration: InputDecoration(
                        labelText: 'Qty',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.selectedEquipment[equipment] =
                              int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
