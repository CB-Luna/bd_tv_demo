import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tv_demo/ui/pages/setup_page/widgets/dropdown.dart';

import '../../../helpers/constants.dart';
import '../../../model/areas_trabajo_model.dart';

class SectionArea extends StatelessWidget {
  Function(bool?)? stateChanger;
  Function(Map<String, dynamic>) onSelect;
  String selectedArea = "";

  SectionArea({super.key, this.stateChanger, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stateChanger!(true);
        return false;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.stars_rounded, size: 80, color: Colors.white
                  // Theme.of(context).colorScheme.secondary,
                  ),
              SizedBox(width: 20),
              Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: const Text(
              'Por favor, indique el área en que nos encontramos:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 30),
          DropdownAreas(onSelect: (selected) => onSelect(selected)),
          const SizedBox(height: 100),
          ElevatedButton(
              onPressed: () {
                stateChanger!(true);
              },
              child: const Text("Regresar")),
          ElevatedButton(
              onPressed: () {
                stateChanger!(false);
              },
              child: const Text("Continuar")),
        ],
      ),
    );
  }
}
