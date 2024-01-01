import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../generated/l10n.dart';
import '../../utils.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserNameScreen(),
      ),
    );
  }

  void _onAppleTap(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
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
                S.of(context).signUpTitle("TikTok"),
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  S.of(context).signUpSubTitle,
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
                  onTap: () => _onAppleTap(context),
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  text: S.of(context).appleButton,
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
                        onTap: () => _onAppleTap(context),
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: S.of(context).appleButton,
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
                  S.of(context).logIn,
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
