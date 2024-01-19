import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/email_screen.dart';

import 'widgets/form_button.dart';

class UserNameScreen extends ConsumerStatefulWidget {
  const UserNameScreen({super.key});

  @override
  ConsumerState<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends ConsumerState<UserNameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;

    ref.read(signUpForm.notifier).state = {"nick" : _username};

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            Opacity(
              opacity: 0.7,
              child: Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
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
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(
                label: "Next",
                disabled: _username.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
