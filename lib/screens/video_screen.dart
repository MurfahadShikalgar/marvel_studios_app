import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
 late VideoPlayerController _controller;

  void _playVideo(){
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.addListener(() => setState(() {}));
    _controller.setLooping(true);
    _controller.initialize().then((value) => _controller.play());
  }

  String _videoDuration(Duration duration){
    String twoDigit(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _playVideo();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            height: 300,
            child: _controller.value.isInitialized ? Column(
              children: [
                SizedBox(
                  height: 200, 
                  child: VideoPlayer(_controller),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _controller, 
                      builder: (context, VideoPlayerValue value, child){
                        return Text(
                          _videoDuration(value.position),
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        );
                      }
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                        ),
                      )
                    )
                  ],
                ),
                IconButton(
                  onPressed: () => _controller.value.isPlaying
                  ? _controller.pause() 
                  : _controller.play(), 
                  icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40,)
                )
              ],
            ) : const Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                ),
          )
        ],
      ),
    );
  }
}

