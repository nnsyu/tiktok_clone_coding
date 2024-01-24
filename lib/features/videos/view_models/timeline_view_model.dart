import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(seconds: 2));
    // final newVideo = VideoModel(title: "${DateTime.now()}");
    // _list = [..._list, newVideo];
    _list = [..._list];
    state = AsyncValue.data(_list); // 새로운 데이터를 state에 넣어주기
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }

}

final timelineProvider = AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(() => TimelineViewModel(),);