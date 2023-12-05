import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

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

  final Duration _animationDuration = const Duration(milliseconds: 200);

  final String hashTag = "#애완동물 #폼피츠 #강아지 #귀여워 #나만 없어 #포메라니안 #웅이 #강아지웅이 ";
  String cutTag = "";
  final String songName =
      "<(EwooTeacher Album) Oong playing in the park Track 1>";

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
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();

    widget.onVideoFinished;
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    } else if (info.visibleFraction != 1 &&
        _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
  }

  void _onTogglePause() {
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
    if(_videoPlayerController.value.isPlaying) {
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

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
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
                      // _videoPlayerController.value.isPlaying
                      //     ? FontAwesomeIcons.pause
                      //     : FontAwesomeIcons.play,
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
                    // Container(
                    //   child: Expanded(
                    //     child: Marquee(
                    //       text: "123",
                    //     ),
                    //   ),
                    // ),
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
                  text: '2.9M',
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: '3.3K',
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
        ],
      ),
    );
  }
}
