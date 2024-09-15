import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoBoxWidget extends StatefulWidget {
  final String url;
  const VideoBoxWidget({required this.url, super.key});

  @override
  State<VideoBoxWidget> createState() => _VideoBoxWidgetState();
}

class _VideoBoxWidgetState extends State<VideoBoxWidget> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;
  bool isInitializing = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      videoPlayerController = CachedVideoPlayerController.network(widget.url);
      await videoPlayerController.initialize();
      videoPlayerController.setVolume(1);
      setState(() {
        isInitializing = false;
      });
    } catch (error) {
      setState(() {
        isError = true;
      });
      print('Error initializing video player: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return Center(
        child: Text('Error loading video'),
      );
    }

    if (isInitializing) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
