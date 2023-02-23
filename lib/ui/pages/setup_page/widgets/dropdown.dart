import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tv_demo/helpers/constants.dart';

import '../../../../model/areas_trabajo_model.dart';

class DropdownAreas extends StatelessWidget {
  Function(Map<String, dynamic>) onSelect;

  DropdownAreas({super.key, required this.onSelect});

  late int IdArea;
  dynamic areaNombre;

  List<GetAreasTrabajo> listaAreas = [];
  Future<List<GetAreasTrabajo>> getAreas() async {
    final areas = await supabase.from("areas_de_trabajo").select('*').execute();
    listaAreas = (areas.data as List<dynamic>)
        .map((e) => GetAreasTrabajo.fromJson(jsonEncode(e)))
        .toList();
    return listaAreas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAreas(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Container());
        }

        return Column(
          children: [
            Container(
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
                    //SECCION DONDE SE RESCATA EL ID Y EL NOMBRE DEL AREA
                    IdArea = int.parse(value.toString());

                    for (var area in snapshot.data!) {
                      if (IdArea == area.idAreaPk) {
                        areaNombre = area.nombreArea;
                      }
                    }

                    onSelect({
                      'id': IdArea,
                      'nombre': areaNombre,
                    });

                    print(IdArea);
                    print(areaNombre);
                  },
                  items: listaAreas
                      .map((e) => DropdownMenuItem(
                          value: e.idAreaPk.toString(),
                          child: Text(e.nombreArea.toString())))
                      .toList(),
                )),
          ],
        );
      },
    );
  }
}
