import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../services/graphql_config.dart';

class VideoScreen extends StatefulWidget {
  final dynamic videoUrl;
  const VideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(setPath(widget.videoUrl))
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    var video = _controller;

    return SizedBox(
        width: video.value.size.width,
        height: video.value.size.height,
        child: VideoPlayer(video));
  }

  @override
  void dispose() {
    super.dispose();
    var video = _controller;
    video.dispose();
  }
}
