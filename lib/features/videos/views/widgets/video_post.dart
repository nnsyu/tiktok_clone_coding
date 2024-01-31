import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoData,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  bool _isPaused = false;
  bool _isSeeMore = false;
  bool _isMute = false;
  bool _isLike = false;
  int _likeCount = 0;

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

    if (!mounted) return;

    if (kIsWeb || ref.read(playbackConfigProvider).muted) {
      _onMute();
    }

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

  void _onPlaybackConfigChanged() {
    if (!mounted) return;

    if (ref.read(playbackConfigProvider).muted) {
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

      final autoplay = ref.read(playbackConfigProvider).autoplay;
      if (!autoplay) _onTogglePause();
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
    _isMute
        ? _videoPlayerController.setVolume(0)
        : _videoPlayerController.setVolume(50);

    setState(() {});
  }

  void _onLikeTap() async {

    await ref.read(videoPostProvider(widget.videoData).notifier).likeVideo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _isLike = ref.read(videoPostProvider(widget.videoData).notifier).like;
    _likeCount = ref.read(videoPostProvider(widget.videoData).notifier).likeCount;

    print("###### _isLike : $_isLike");
    print("###### _likeCount : $_likeCount");


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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
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
                  '@${widget.videoData.creator}',
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v16,
                Text(
                  widget.videoData.description,
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
                      'https://firebasestorage.googleapis.com/v0/b/tiktok-clone-ewoo.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media'),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onLikeTap(),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    iconColor: _isLike ? Colors.redAccent : Colors.white,
                    text: "$_likeCount",
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    iconColor: Colors.white,
                    text: S.of(context).commentCount(widget.videoData.comments),
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.share,
                  iconColor: Colors.white,
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
