import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authRepository = ref.read(authRepo);
    if (_authRepository.isLoggedIn) {
      final profile =
          await _usersRepository.findProfile(_authRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    print("@@@@@@@@@@@uid : ${credential.user!.uid}");

    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);

    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: credential.user!.displayName ?? "Anon",
      bio: "undefined",
      link: "undefined",
      nick: form["nick"] ?? "Anon",
      birthday: form["birthday"] ?? "0000",
      hasAvatar: false,
    );

    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    state = AsyncValue.data(
      state.value!.copyWith(
        hasAvatar: true,
      ),
    );
    await _usersRepository.updateUser(state.value!.uid, {
      "hasAvatar": true,
    });
  }

  Future<void> onEditInfo(String bio, String link) async {
    state = AsyncValue.data(
      state.value!.copyWith(
        bio: bio,
        link: link,
      ),
    );
    await _usersRepository.updateUser(state.value!.uid, {
      "bio": bio,
      "link": link,
    });
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
