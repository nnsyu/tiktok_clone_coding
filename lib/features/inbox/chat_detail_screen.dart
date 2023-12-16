import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size5,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34337539?v=4',
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: Sizes.size16,
                  height: Sizes.size16,
                  decoration: BoxDecoration(
                    color: Color(0xFF8AFF36),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            '에우선생',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 50,
                  ),
                  color: Color(0x37F1F1F1),
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.size20,
                        horizontal: Sizes.size14,
                      ),
                      itemBuilder: (context, index) {
                        final isMine = index % 2 == 0;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                Sizes.size14,
                              ),
                              decoration: BoxDecoration(
                                  color: isMine
                                      ? Colors.blue
                                      : Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      Sizes.size20,
                                    ),
                                    topRight: Radius.circular(
                                      Sizes.size20,
                                    ),
                                    bottomLeft: Radius.circular(
                                      isMine ? Sizes.size20 : Sizes.size3,
                                    ),
                                    bottomRight: Radius.circular(
                                      isMine ? Sizes.size3 : Sizes.size20,
                                    ),
                                  )),
                              child: Text(
                                "this is a message!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: 20),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Sizes.size10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0,
                            ),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              Text('\u{1f496}'),
                              Gaps.h3,
                              Text('\u{1f496}'),
                              Gaps.h3,
                              Text('\u{1f496}'),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                            vertical: Sizes.size5,
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0,
                            ),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              Text('\u{1F44D}'),
                              Gaps.h3,
                              Text('\u{1F44D}'),
                              Gaps.h3,
                              Text('\u{1F44D}'),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                            vertical: Sizes.size5,
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0,
                            ),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              Text('\u{1F605}'),
                              Gaps.h3,
                              Text('\u{1F605}'),
                              Gaps.h3,
                              Text('\u{1F605}'),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                            vertical: Sizes.size5,
                          ),
                        ),
                        Gaps.h10,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomAppBar(
            padding: EdgeInsets.only(
              bottom: Sizes.size20,
            ),
            color: Color(0x37F1F1F1),
            elevation: 0,
            height: size.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size12,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: Colors.grey.shade900,
                              size: Sizes.size24,
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.size12,
                          vertical: Sizes.size10,
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  Container(
                    padding: EdgeInsets.all(
                      Sizes.size10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Colors.white,
                      size: Sizes.size16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
