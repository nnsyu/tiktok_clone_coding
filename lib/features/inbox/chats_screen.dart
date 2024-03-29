import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chat";
  static const String routeURL = "/chat";

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      print("deleteIndex : $index");
      _key.currentState!.removeItem(
        index,
        (context, animation) => FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: Breakpoints.sm,
                ),
                color: Colors.red,
                child: _makeTile(index),
              ),
            ),
          ),
        ),
        duration: _duration,
      );
      _items.remove(index);
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {
        "chatId": "$index",
      },
    );
  }

  Widget _makeTile(int index) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Breakpoints.sm,
        ),
        child: ListTile(
          onLongPress: () => _deleteItem(index),
          onTap: () => _onChatTap(index),
          leading: CircleAvatar(
            radius: 30,
            child: Text("Ewoo"),
            foregroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/34337539?v=4',
            ),
            backgroundColor: Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Ratgys ($index)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2:16 PM',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: Sizes.size12,
                ),
              ),
            ],
          ),
          subtitle: Text("Don't forget to make video"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Direct Messages'),
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
