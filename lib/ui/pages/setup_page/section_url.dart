import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tv_demo/helpers/constants.dart';
import 'package:tv_demo/services/local_storage.dart';

class SectionUrl extends StatelessWidget {
  Function(bool?)? stateChanger;

  SectionUrl({super.key, this.stateChanger});

  TextEditingController _urlController = TextEditingController();
  TextEditingController _keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              'Por favor, indique el URL donde se encuentra la base de datos:',
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
          const TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(gapPadding: 0),
              labelText: 'URL',
            ),
          ),
          const SizedBox(height: 30),
          const TextField(
            style: TextStyle(color: Colors.white),
            strutStyle: StrutStyle(
              forceStrutHeight: true,
              height: 1.5,
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              iconColor: Colors.white,
              focusColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'AnonKey',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                String sb_url = _urlController.text;
                String sb_key = _keyController.text;

                await supabase.dispose();
                await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
                supabase = Supabase.instance.client;
                try {
                  final areas = await supabase
                      .from("areas_de_trabajo")
                      .select('*')
                      .execute();
                } catch (e) {
                  print("catched");
                }

                // stateChanger!(false);
              },
              child: const Text("Continuar")),
        ]);
  }
}
