import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTab(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        centerTitle: true,
        title: Text('Inbox'),
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: FaIcon(
              FontAwesomeIcons.paperPlane,
              size: Sizes.size20,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: ListView(
            children: [
              ListTile(
                onTap: () => _onActivityTab(context),
                title: Text(
                  'Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size18,
                  ),
                ),
                trailing: FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
              Container(
                height: Sizes.size1,
                color: Colors.grey.shade200,
              ),
              ListTile(
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.users,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  'New followers',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size16,
                  ),
                ),
                subtitle: Text(
                  'Messages from followers will appear here',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                trailing: FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
