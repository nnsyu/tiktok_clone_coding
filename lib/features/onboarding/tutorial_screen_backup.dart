import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/tutorial_page.dart';

import '../../constants/sizes.dart';

class TutorialScreenBackup extends StatefulWidget {
  const TutorialScreenBackup({super.key});

  @override
  State<TutorialScreenBackup> createState() => _TutorialScreenBackupState();
}

class _TutorialScreenBackupState extends State<TutorialScreenBackup> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNextTab() {
    if (_selectedIndex == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(
            tab: "home",
          ),
        ),
        (route) => false,
      );
    } else {
      setState(() {
        _selectedIndex++;
      });
    }
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0 ? true : false,
      onPopInvoked: (didPop) {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex--;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/34337539?v=4'),
                ),
                Gaps.v10,
                Stack(
                  children: [
                    Offstage(
                      offstage: _selectedIndex != 0,
                      child: TutorialPage(
                        isCurrent: _selectedIndex == 0,
                        title: "Watch cool videos!",
                        content:
                            "Videos are personalized for you based on what you watch, like, and share.",
                      ),
                    ),
                    Offstage(
                      offstage: _selectedIndex != 1,
                      child: TutorialPage(
                        isCurrent: _selectedIndex == 1,
                        title: "Follow the rules!",
                        content: "Take care of one another! Please!",
                      ),
                    ),
                    Offstage(
                      offstage: _selectedIndex != 2,
                      child: TutorialPage(
                        isCurrent: _selectedIndex == 2,
                        title: "Enjoy your ride!",
                        content:
                            "Videos are personalized for you based on what you watch, like, and share.",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: CupertinoButton(
            onPressed: _onNextTab,
            color: Theme.of(context).primaryColor,
            child: Text(_selectedIndex == 2 ? 'Enter the app!' : 'Next'),
          ),
        ),
      ),
    );
  }
}
