import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:video_player/video_player.dart';

class SmallChewieDemo extends StatefulWidget {
  const SmallChewieDemo({
    super.key,
    required this.video,
  });

  final String video;

  @override
  State<StatefulWidget> createState() {
    return _SmallChewieDemoState();
  }
}

class _SmallChewieDemoState extends State<SmallChewieDemo> {
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [];

  Future<void> initializePlayer() async {
    srcs.add(widget.video);

    _videoPlayerController1 = VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
    _videoPlayerController2 = VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      progressIndicatorDelay: bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 1),
      allowFullScreen: false,
      //allowPlaybackSpeedChanging: false,
      allowMuting: false,
      // showControls: false,
      customControls: const Center(child: Icon(Icons.play_circle)),
      autoPlay: true,
      aspectRatio: 1,
    );
  }

  int currPlayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized)
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: LoadingWidget()),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({super.key, required this.delay, required this.onSave});

  final int? delay;
  final void Function(int?) onSave;

  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
