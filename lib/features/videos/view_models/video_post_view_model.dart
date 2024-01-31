import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, VideoModel> {
  late final VideosRepository _repository;
  late final _video;
  bool like = false;
  int likeCount = 0;

  @override
  FutureOr<void> build(VideoModel video) async {
    _video = video;
    _repository = ref.read(videosRepo);
    like = await isLike();
    likeCount = video.likes;
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    like = await _repository.likeVideo(_video.id, user!.uid);
    like ? likeCount++ : likeCount--;
  }

  Future<bool> isLike() async {
    final user = ref.read(authRepo).user;
    return await _repository.isLike(_video.id, user!.uid);
  }
}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel, void, VideoModel>(
  () => VideoPostViewModel(),
);
