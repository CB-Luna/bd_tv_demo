import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tv_demo/classes/graphql_call.dart';
import 'package:tv_demo/queries/test_video_query.dart';
import 'package:tv_demo/ui/video_screen.dart';

import 'services/graphql_config.dart';

void main() {
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
      child: GraphQLProvider(
        client: GraphQLConfiguration.clientToQuery(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TV Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const DataCall(query: queryTestVideo, page: videoContent),
        ),
      ),
    );
  }
}

Widget videoContent(result, context) {
  var testData = result.data?['pageTestimon']['data']['attributes'];

  //VIDEO

  var testVideo = testData['Video']['data']['attributes']['url'];

  return VideoScreen(videoUrl: testVideo);
}
