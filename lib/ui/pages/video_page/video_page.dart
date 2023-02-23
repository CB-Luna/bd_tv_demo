import 'package:flutter/material.dart';
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../helpers/constants.dart';
import '../../spinner.dart';
import '../../video_screen.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class VideoPage extends StatefulWidget {
  final int idTV;

  const VideoPage({Key? key, required this.idTV}) : super(key: key);

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late SupabaseStreamBuilder videoStream = supabase
      .from('video_actual_tv_view')
      .stream(primaryKey: ['tv']).eq('tv', widget.idTV);

  @override
  void initState() {
    _loadVideo();
    super.initState();
  }

  Future<void> _loadVideo() async {
    await Future.delayed(Duration.zero);

    //Llamado en tiempo real para validar algún update en la tabla de reproducciones
    supabase.channel('public:reproducciones').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: 'public', table: 'reproducciones'),
      (payload, [ref]) {
        setState(() {
          videoStream = supabase
              .from('video_actual_tv_view')
              .stream(primaryKey: ['tv']).eq('tv', widget.idTV);
        });
      },
    ).subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: videoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Spinner());
          }
          final videos = snapshot.data!;

          return VideoScreen(
            videoUrl: videos.first['url_video_actual'],
            key: UniqueKey(),
          );
        });
  }
}
