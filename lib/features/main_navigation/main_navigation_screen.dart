import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/upload_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;
  bool _isTapDown = false;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Record video'),
          ),
        ),
        fullscreenDialog: true,
      ),
    );

    setState(() {
      _selectedIndex = 0;
      _isTapDown = false;
    });
  }

  void _onPostVideoButtonTapDown(TapDownDetails details) {
    setState(() {
      _isTapDown = true;
    });
  }

  void _onPostVideoButtonTapCancel() {
    setState(() {
      _isTapDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavTab(
              text: 'Home',
              isSelected: _selectedIndex == 0,
              icon: CupertinoIcons.house,
              selectedIcon: CupertinoIcons.house_fill,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: 'Discover',
              isSelected: _selectedIndex == 1,
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            GestureDetector(
              onTapCancel: _onPostVideoButtonTapCancel,
              onTap: _onPostVideoButtonTap,
              onTapDown: _onPostVideoButtonTapDown,
              // onTapUp: _onPostVideoButtonTapUp,
              child: UploadVideoButton(
                isSelected: _isTapDown,
                inverted: _selectedIndex == 0,
              ),
            ),
            Gaps.h24,
            NavTab(
              text: 'Inbox',
              isSelected: _selectedIndex == 3,
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              onTap: () => _onTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: 'Profile',
              isSelected: _selectedIndex == 4,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              onTap: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
