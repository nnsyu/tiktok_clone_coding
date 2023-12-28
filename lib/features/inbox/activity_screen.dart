import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notification = List.generate(20, (index) => "${index}h");

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    _notification.remove(notification);
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 1,
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('All Activity'),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                    ),
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Gaps.v14,
                  for (var notification in _notification)
                    Dismissible(
                      key: Key(notification),
                      onDismissed: (direction) => _onDismissed(notification),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Sizes.size10,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.checkDouble,
                            color: Colors.white,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Sizes.size10,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.trashCan,
                            color: Colors.white,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
                      child: ListTile(
                        minVerticalPadding: Sizes.size16,
                        leading: Container(
                          width: Sizes.size52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: Sizes.size1,
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.bell,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: "Account updates: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: Sizes.size14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Upload longer videos ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: Sizes.size14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " $notification",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.shade500,
                                        fontSize: Sizes.size14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.h16,
                          ],
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: Sizes.size16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: Breakpoints.sm,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      Sizes.size5,
                    ),
                    bottomRight: Radius.circular(
                      Sizes.size5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var tab in _tabs)
                      ListTile(
                        title: Row(
                          children: [
                            FaIcon(
                              tab["icon"],
                              color: Colors.black,
                              size: Sizes.size16,
                            ),
                            Gaps.h20,
                            Text(
                              tab["title"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
