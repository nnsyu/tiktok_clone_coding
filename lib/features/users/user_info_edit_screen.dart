import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UserInfoEditScreen extends ConsumerStatefulWidget {
  static const String routeName = "userInfoEdit";
  static const String routeURL = "/userinfoedit";

  const UserInfoEditScreen({super.key});

  @override
  ConsumerState createState() => _UserInfoEditScreenState();
}

class _UserInfoEditScreenState extends ConsumerState<UserInfoEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmmitTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await ref.read(usersProvider.notifier).onEditInfo(
              formData["bio"]!,
              formData["link"]!,
            );
        context.pop();
      }
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Your Info"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'bio',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? "please check your bio"
                        : null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['bio'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'link',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? "please check your ink"
                        : null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['link'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmmitTap,
                  child: FormButton(
                    label: "Edit Complete",
                    disabled: ref.watch(usersProvider).isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
