import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/features/player/games/models/output_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final OutputModel outputModel;
  final VoidCallback? onVideoComplete;

  const VideoPlayerWidget({
    super.key,
    required this.outputModel,
    this.onVideoComplete,
  });

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  String? videoPath;
  bool _didCompleteVideo = false;

  @override
  void initState() {
    super.initState();
    _setupVideo();
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the data or type changed, reset the video
    if (oldWidget.outputModel.data != widget.outputModel.data ||
        oldWidget.outputModel.type != widget.outputModel.type) {
      _setupVideo();
    }
  }

  void _setupVideo() {
    // Remove old listeners and dispose old controller
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _didCompleteVideo = false;

    // Only set up if valid data and type == 'video'
    if (widget.outputModel.data != null && widget.outputModel.type == 'video') {
      // For example: 'assets/videos/example.mp4'
      videoPath = 'assets/videos/${widget.outputModel.data}';
      _controller = VideoPlayerController.asset(videoPath!);

      _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
        setState(() {});
        _controller!.setLooping(false);
        _controller!.addListener(_videoListener);
      }).catchError((error) {
        debugPrint('Error initializing video: $error');
      });
    } else {
      videoPath = null;
      _controller = null;
    }
  }

  void _videoListener() {
    // If the video is finished playing (position >= duration)
    if (!_didCompleteVideo &&
        _controller!.value.position >= _controller!.value.duration &&
        _controller!.value.duration != Duration.zero) {
      _didCompleteVideo = true;
      widget.onVideoComplete?.call();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    if (videoPath == null) {
      return Center(
        child: Text(
          'No video available.',
          style: TextStyle(
            color: AppColors.kDarkGreyColor,
            fontSize: 16.sp,
          ),
        ),
      );
    }

    if (_controller == null) {
      return Center(
        child: Text(
          'Unable to load video.',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.sp,
          ),
        ),
      );
    }

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading video.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
              ),
            ),
          );
        } else {
          // Video is initialized and ready to play
          return Center(
            child: SizedBox(
              width: _controller!.value.size.width,
              height: 500, // You can adjust this fixed height
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(
                          _controller!,
                        ),
                      ),
                    ),
                  ),
                  ControlsOverlay(controller: _controller!),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: false,
                      colors: VideoProgressColors(
                        playedColor: AppColors.kPrimary1Color,
                        bufferedColor: AppColors.kLightGreyColor,
                        backgroundColor:
                            AppColors.kDarkGreyColor.withOpacity(0.3),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreyColor.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: _buildVideoPlayer(),
      ),
    );
  }
}

class ControlsOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const ControlsOverlay({super.key, required this.controller});

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When tapped, if the video isn't playing, start it
      onTap: () {
        if (!widget.controller.value.isPlaying) {
          setState(() {
            widget.controller.play();
          });
        }
      },
      child: Stack(
        children: <Widget>[
          // Show a large play button (fades out once playing)
          Center(
            child: AnimatedOpacity(
              opacity: widget.controller.value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.play_circle_fill,
                size: 64.sp,
                color: AppColors.kPrimary1Color.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
