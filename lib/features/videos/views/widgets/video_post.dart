import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/app_configuration/common_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isSeeMore = false;
  bool _isMute = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  final String hashTag = "#애완동물 #폼피츠 #강아지 #귀여워 #나만 없어 #포메라니안 #웅이 #강아지웅이 ";
  String cutTag = "";
  final String songName =
      "<(EwooTeacher Album) Oong playing in the park Track 1>";

  late final PlaybackConfigViewModel readPlaybackVM;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/oong.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    if(!mounted) return;

    if (kIsWeb || readPlaybackVM.muted) {
      _onMute();
    }

    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readPlaybackVM = context.read<PlaybackConfigViewModel>();

    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    readPlaybackVM.addListener(_onPlaybackConfigChanged);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();

    widget.onVideoFinished;
  }

  void _onPlaybackConfigChanged() {
    if(!mounted) return;

    final muted = readPlaybackVM.muted;
    if(muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(50);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
      final autoplay = readPlaybackVM.autoplay;

      if(!autoplay) _onTogglePause();
    }

    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (!mounted) return;

    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  String showCutTag(String tag) {
    String ret = tag.replaceRange(15, tag.length, " ... ");

    return ret;
  }

  void _onSeeMoreClick() {
    //cutTag = showCutTag(hashTag);
    _isSeeMore = !_isSeeMore;
    setState(() {});
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VideoComments(),
    );

    _onTogglePause();
  }

  void _onMute() {
    _isMute = !_isMute;
    _isMute ? _videoPlayerController.setVolume(0) : _videoPlayerController.setVolume(50);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width ?? 0,
                        height: _videoPlayerController.value.size.height ?? 0,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@ewoo',
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v16,
                Text(
                  'This is my pet name is oong !!',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
                Gaps.v8,
                Container(
                  width: MediaQuery.of(context).size.width * 0.7, // 너비를 제한
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: _isSeeMore ? hashTag : showCutTag(hashTag),
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: _isSeeMore ? 'fold' : 'See ',
                          style: TextStyle(
                            color: Color(0xFFB8C7E1),
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onSeeMoreClick,
                        ),
                        TextSpan(
                          text: _isSeeMore ? '' : 'more',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onSeeMoreClick,
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.v8,
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.music,
                      size: Sizes.size12,
                      color: Colors.white,
                    ),
                    Gaps.h10,
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/34337539?v=4'),
                  child: Text('에우'),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(987987967678687),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(6565656565),
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: 'Share',
                ),
              ],
            ),
          ),
          Positioned(
            left: Sizes.size24,
            top: Sizes.size48,
            // child: GestureDetector(
            //   onTap: _onMute,
            //   child: FaIcon(
            //     _isMute ? FontAwesomeIcons.volumeXmark : FontAwesomeIcons.volumeHigh,
            //     color: Colors.white,
            //     size: Sizes.size24,
            //   ),
            // ),
            child: GestureDetector(
              onTap: () {
                _onMute();
              },
              child: FaIcon(
                _isMute
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
                size: Sizes.size24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
