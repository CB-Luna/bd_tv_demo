import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tv_demo/model/areas_trabajo_model.dart';

import '../../../helpers/constants.dart';
import '../../../model/televisiones_model.dart';

class SectionType extends StatefulWidget {
  dynamic stateChanger;
  dynamic IdTv;
  String Area;

  SectionType({super.key, this.stateChanger, this.IdTv, required this.Area});

  @override
  State<SectionType> createState() => _SectionTypeState();
}

class _SectionTypeState extends State<SectionType> {
  List<GetTelevisiones> listaTelevisiones = [];
  int _selectedTV = -1;
  int _focusedTV = -1;

  Future<List<GetTelevisiones>> getTelevisiones() async {
    final televisiones = await supabase
        .from("televisores")
        .select("*")
        .eq("area", widget.IdTv)
        .execute();
    listaTelevisiones = (televisiones.data as List<dynamic>)
        .map((e) => GetTelevisiones.fromJson(jsonEncode(e)))
        .toList();

    return listaTelevisiones;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTelevisiones(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return WillPopScope(
            onWillPop: () async {
              widget.stateChanger();
              return false;
            },
            child: Column(
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
                      Text(
                        widget.Area,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Text(
                      'Seleccione uno de los dispositivos disponibles para el área de ${widget.Area.toLowerCase()}:',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 185,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        children: [
                          for (var tv in listaTelevisiones)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FractionallySizedBox(
                                  widthFactor: 0.18,
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          const Icon(Icons.tv, size: 100),
                                          Positioned(
                                              top: 34,
                                              left: 37,
                                              child: Container(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedTV = tv.id;
                                                      });
                                                      print(_selectedTV);
                                                    },
                                                    onFocusChange: (v) {
                                                      if (v) {
                                                        setState(() {
                                                          _focusedTV = tv.id;
                                                        });
                                                      }
                                                    },
                                                    child: tv.id == _selectedTV
                                                        ? Icon(
                                                            Icons.check_circle,
                                                            color: tv.id ==
                                                                    _focusedTV
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: tv.id ==
                                                                    _focusedTV
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                          )),
                                              )),
                                        ],
                                      ),
                                      Text(
                                        "TV ${tv.id}",
                                        style: const TextStyle(fontSize: 26),
                                      ),
                                    ],
                                  )),
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: widget.stateChanger,
                      child: const Text("Regresar")),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Confirmar"))
                ]));
      },
    );
  }
}
