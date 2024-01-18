import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/email_screen.dart';
import 'package:tiktok_clone/features/authentication/views/login_screen.dart';
import 'package:tiktok_clone/features/authentication/views/username_screen.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static String routeName = "signUp";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    // Navigator 2 GoRouter
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator 2 GoRouter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserNameScreen(),
      ),
    );
  }

  void _onGithubTap(BuildContext context, WidgetRef ref) {
    ref.read(socialAuthProvider.notifier).githubSignIn(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(Localizations.localeOf(context));

    final orientation = MediaQuery.of(context).orientation;

    // if(orientation == Orientation.landscape) {
    //   return const Scaffold(
    //       body: Center(
    //         child: Text("Please rotate screen"),
    //       ),
    //     );
    // }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                S.of(context).signUpTitle("TikTok", DateTime.now()),
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  S.of(context).signUpSubTitle(1),
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              if (orientation == Orientation.portrait) ...[
                AuthButton(
                  onTap: () => _onEmailTap(context),
                  icon: const FaIcon(FontAwesomeIcons.user),
                  text: S.of(context).emailPasswordButton,
                ),
                Gaps.v16,
                AuthButton(
                  onTap: () => _onGithubTap(context, ref),
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  text: S.of(context).githubButton,
                ),
              ],
              if (orientation == Orientation.landscape)
                Row(
                  children: [
                    Expanded(
                      child: AuthButton(
                        onTap: () => _onEmailTap(context),
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.h16,
                    Expanded(
                      child: AuthButton(
                        onTap: () => _onGithubTap(context, ref),
                        icon: const FaIcon(FontAwesomeIcons.github),
                        text: S.of(context).githubButton,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: isDarkMode(context)
            ? Theme.of(context).appBarTheme.backgroundColor
            : Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size32,
            bottom: Sizes.size64,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).alreadyHaveAnAccount,
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  S.of(context).logIn("other"),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
