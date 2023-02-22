import 'package:flutter/material.dart';
import 'package:tv_demo/ui/pages/setup_page/widgets/dropdown.dart';

class SectionArea extends StatelessWidget {
  dynamic stateChanger;
  String selectedArea = "";

  SectionArea({super.key, this.stateChanger});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.stars_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 20),
            const Text(
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
        const DropdownAreas(),
        const SizedBox(height: 100),
        ElevatedButton(onPressed: stateChanger, child: const Text("Continuar")),
      ],
    );
  }
}
