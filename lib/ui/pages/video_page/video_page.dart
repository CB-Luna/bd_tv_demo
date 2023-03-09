import 'package:flutter/material.dart';
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tv_demo/services/local_storage.dart';
import 'package:tv_demo/ui/pages/setup_page/setup_page.dart';

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

          return Stack(
            children: [
              VideoScreen(
                videoUrl: videos.first['url_video_actual'],
                key: UniqueKey(),
              ),
              Positioned(
                  top: 30,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Scaffold(body: SetupPage()),
                      ));
                      SPLocalStorage.prefs.setBool("assigned", false);
                      SPLocalStorage.prefs.setInt("assignedID", -1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.arrow_back, color: Colors.white, size: 24),
                          SizedBox(width: 5),
                          Text(
                            "Volver",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          );
        });
  }
}
