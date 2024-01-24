import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class EditInfoViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> editInfo(String bio, String link) async {
    state = AsyncValue.loading();
    state = ref.read(usersProvider);
  }
}

final userEditInfoProvider = AsyncNotifierProvider<EditInfoViewModel, void>(
  () => EditInfoViewModel(),
);
