import 'package:flutter/material.dart';

final items = [
  "a1",
  "a2",
  "a3",
];

class DropdownAreas extends StatelessWidget {
  const DropdownAreas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: 300,
      child: DropdownButtonFormField(
          hint: Container(
              child: Text(
            'Selecciona un área',
          )),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          onChanged: (value) {
            print(value);
          },
          items: items
              .map((name) => DropdownMenuItem(
                    child: Text(name),
                    value: name,
                  ))
              .toList()),
    );
  }
}
