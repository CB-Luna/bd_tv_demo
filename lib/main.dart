import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tv_demo/classes/graphql_call.dart';
import 'package:tv_demo/queries/test_video_query.dart';
import 'package:tv_demo/ui/pages/setup_page/setup_page.dart';
import 'package:tv_demo/ui/video_screen.dart';
import './theme/theme_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tv_demo/helpers/constants.dart';
import 'package:tv_demo/ui/spinner.dart';

import 'ui/video_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TV View',
        theme: defaultTheme,
        home: const Scaffold(body: SetupPage()), // SETUP PAGE
        // home: Center(child: videoContent(context)),   // VIDEO VIEW
      ),
    );
  }
}

Widget videoContent(context) {
  var videoStream = supabase
      .from('video_actual_tv_view')
      .stream(primaryKey: ['tv']).eq('tv', 5);

  return StreamBuilder(
      stream: videoStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Spinner());
        }
        final videos = snapshot.data!;

        return VideoScreen(videoUrl: videos.first['url_video_actual']);
      });
}
