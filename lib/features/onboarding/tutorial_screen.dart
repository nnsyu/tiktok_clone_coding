import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/tutorial_page.dart';

import '../../constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(),
      ),
          (route) => false,
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // to right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // to left
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: _onPanEnd,
      onPanUpdate: _onPanUpdate,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const TutorialPage(
                isCurrent: false,
                title: "Watch cool videos!",
                content:
                    "Videos are personalized for you based on what you watch, like, and share.",
              ),
              secondChild: const TutorialPage(
                isCurrent: false,
                title: "Follow the rules!",
                content: "Take care of one another! Please!",
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(
                milliseconds: 300,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              opacity: _showingPage == Page.first ? 0 : 1,
              duration: Duration(
                milliseconds: 300,
              ),
              child: CupertinoButton(
                onPressed: _onEnterAppTap,
                color: Theme.of(context).primaryColor,
                child: Text('Enter the app!'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


