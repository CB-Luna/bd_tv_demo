import 'package:flutter/material.dart';

class SectionType extends StatelessWidget {
  dynamic stateChanger;

  SectionType({super.key, this.stateChanger});

  List<dynamic> tvs = [
    {
      "id": "1",
      "available": false,
    },
    {
      "id": "2",
      "available": true,
    },
    {
      "id": "3",
      "available": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 5; i++) {
      tvs = [...tvs, ...tvs];
    }

    return WillPopScope(
        onWillPop: () async {
          stateChanger();
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
                  const Text(
                    'Comedor',
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
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const Text(
                  'Seleccione uno de los dispositivos disponibles para comedor:',
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
              SizedBox(
                height: 185,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    children: [
                      for (var tv in tvs)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FractionallySizedBox(
                              widthFactor: 0.18,
                              child: Column(
                                children: [
                                  // Icon(
                                  //     tv["available"]
                                  //         ? Icons.check_box_outline_blank
                                  //         : Icons.check_box,
                                  //     color: tv["available"]
                                  //         ? Theme.of(context)
                                  //             .colorScheme
                                  //             .primary
                                  //         : Colors.grey,
                                  //     size: 20),
                                  // Container(
                                  //   child: ElevatedButton(
                                  //       style: ElevatedButton.styleFrom(
                                  //           backgroundColor: tv["available"]
                                  //               ? Theme.of(context)
                                  //                   .colorScheme
                                  //                   .primary
                                  //               : Colors.grey),
                                  //       onPressed: () {},
                                  //       child: Text(
                                  //         "TV ${tv["id"]}",
                                  //         style: const TextStyle(fontSize: 26),
                                  //       )),
                                  // ),
                                  Stack(
                                    children: [
                                      const Icon(Icons.tv, size: 100),
                                      Positioned(
                                          top: -10,
                                          left: 26,
                                          child: IconButton(
                                              onPressed: () {},
                                              hoverColor: Colors.red,
                                              icon: tv["available"]
                                                  ? const Icon(
                                                      Icons
                                                          .check_box_outline_blank,
                                                      color: Colors.grey,
                                                    )
                                                  : const Icon(
                                                      Icons.check_circle,
                                                      color: Colors.grey,
                                                    ))),
                                    ],
                                  ),
                                  Text(
                                    "TV ${tv["id"]}",
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
                  onPressed: stateChanger, child: const Text("Regresar")),
              ElevatedButton(onPressed: () {}, child: const Text("Confirmar"))
            ]));
  }
}
