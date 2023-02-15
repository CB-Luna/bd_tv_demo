import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tv_demo/helpers/constants.dart';

import '../../../../model/areas_trabajo_model.dart';


class DropdownAreas extends StatelessWidget {
  const DropdownAreas({super.key});

  @override
  Widget build(BuildContext context) {
    List<GetAreasTrabajo> listaAreas = [];
    var areas = supabase.from("areas_de_trabajo").select('*');

    return FutureBuilder(
      future: areas,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Container());
        }

        print(snapshot.data!);
        // print(areasList);
        listaAreas = (snapshot.data as List<dynamic>)
            .map((e) => GetAreasTrabajo.fromJson(jsonEncode(e)))
            .toList();

        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 300,
            child: DropdownButtonFormField<String>(
              hint: const Text(
                'Selecciona un área',
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
              onChanged: (value) {
                print(value);
              },
              items: listaAreas
                  .map((e) => DropdownMenuItem(
                      value: e.idAreaPk.toString(),
                      child: Text(e.nombreArea.toString())))
                  .toList(),
            ));
      },
    );
  }
}
