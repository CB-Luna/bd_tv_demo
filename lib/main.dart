import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tv_demo/ui/pages/setup_page/setup_page.dart';
import 'package:tv_demo/services/local_storage.dart';
import './theme/theme_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tv_demo/helpers/constants.dart';

import 'ui/pages/video_page/video_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPLocalStorage.configurePrefs();
  String sb_url = SPLocalStorage.prefs.getString("sb_url") ?? "";
  String sb_key = SPLocalStorage.prefs.getString("sb_key") ?? "";
  if (sb_url != "" && sb_key != "") {
    await Supabase.initialize(url: sb_url, anonKey: sb_key);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool assigned = SPLocalStorage.prefs.getBool('assigned') ?? false;
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reproductor TV',
        theme: defaultTheme,
        // home: const Scaffold(body: SetupPage()), // SETUP PAGE
        home: Scaffold(
            body: assigned
                ? VideoPage(idTV: SPLocalStorage.prefs.getInt("assignedID")!)
                : const SetupPage()), // SETUP PAGE
      ),
    );
  }
}

/// VARIABLES DE SHAREDPREFERENCES
/// assigned: bool (demuestra si ya se ha asignado una TV)
/// assignedID: int (id de la TV asignada)
/// sb_url: String (url de supabase asignada)
/// sb_key: String (anonKey de supabase asignada)