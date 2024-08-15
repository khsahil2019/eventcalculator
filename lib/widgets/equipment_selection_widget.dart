import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/models/models.dart';

class EquipmentSelectionWidget extends StatefulWidget {
  final List<Equipment> hourlyEquipmentOptions;
  final List<Equipment> dailyEquipmentOptions;
  final Map<String, EquipmentQuantity> selectedEquipment;

  EquipmentSelectionWidget({
    required this.hourlyEquipmentOptions,
    required this.dailyEquipmentOptions,
    required this.selectedEquipment,
  });

  @override
  _EquipmentSelectionWidgetState createState() =>
      _EquipmentSelectionWidgetState();
}

class _EquipmentSelectionWidgetState extends State<EquipmentSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Hourly Equipment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: widget.hourlyEquipmentOptions.map((equipment) {
                return _buildEquipmentRow(equipment, true);
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              "Select Daily Equipment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: widget.dailyEquipmentOptions.map((equipment) {
                return _buildEquipmentRow(equipment, false);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentRow(Equipment equipment, bool isHourly) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.selectedEquipment.containsKey(equipment.name),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        widget.selectedEquipment[equipment.name] =
                            EquipmentQuantity(
                                quantity: 1,
                                hours: isHourly ? 1 : 0,
                                days: isHourly ? 0 : 1);
                      } else {
                        widget.selectedEquipment.remove(equipment.name);
                      }
                    });
                  },
                ),
                Text(equipment.name),
              ],
            ),
            if (widget.selectedEquipment.containsKey(equipment.name))
              SizedBox(
                width: 50,
                height: 40,
                child: TextFormField(
                  initialValue: widget
                      .selectedEquipment[equipment.name]!.quantity
                      .toString(),
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
                      widget.selectedEquipment[equipment.name] =
                          widget.selectedEquipment[equipment.name]!.copyWith(
                        quantity: int.tryParse(value) ?? 1,
                      );
                    });
                  },
                ),
              ),
          ],
        ),
        if (widget.selectedEquipment.containsKey(equipment.name))
          Row(
            children: [
              if (isHourly)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextFormField(
                      initialValue: widget
                          .selectedEquipment[equipment.name]!.hours
                          .toString(),
                      decoration: InputDecoration(
                        labelText: 'Hours',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.selectedEquipment[equipment.name] = widget
                              .selectedEquipment[equipment.name]!
                              .copyWith(
                            hours: int.tryParse(value) ?? 1,
                          );
                        });
                      },
                    ),
                  ),
                ),
              if (!isHourly)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextFormField(
                      initialValue: widget
                          .selectedEquipment[equipment.name]!.days
                          .toString(),
                      decoration: InputDecoration(
                        labelText: 'Days',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.selectedEquipment[equipment.name] = widget
                              .selectedEquipment[equipment.name]!
                              .copyWith(
                            days: int.tryParse(value) ?? 1,
                          );
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        SizedBox(height: 10.0), // Add some spacing between rows
      ],
    );
  }
}
