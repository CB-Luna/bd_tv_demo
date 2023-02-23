import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final dynamic videoUrl;
  const VideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller =
      VideoPlayerController.network(widget.videoUrl);

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});

        super.initState();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: VideoPlayer(_controller));
  }

  @override
  void dispose() {
    super.dispose();
    var video = _controller;
    video.dispose();
  }
}
