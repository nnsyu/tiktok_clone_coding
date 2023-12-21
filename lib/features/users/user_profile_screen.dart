import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text('EWOO'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.gear,
                  size: Sizes.size20,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/34337539?v=4',
                  ),
                  child: Text("에우"),
                ),
                Gaps.v16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@ewoo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    Gaps.h3,
                    FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size16,
                      color: Colors.lightBlue.shade200,
                    ),
                  ],
                ),
                Gaps.v16,
                SizedBox(
                  height: Sizes.size48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopCount(
                        count: '37',
                        label: "Following",
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade300,
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      PopCount(
                        count: '10.5M',
                        label: 'Followers',
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade300,
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      PopCount(
                        count: '194.3M',
                        label: 'Likes',
                      ),
                    ],
                  ),
                ),
                Gaps.v16,
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.size3),
                              ),
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.size3),
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.youtube,
                              size: Sizes.size20,
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.size3),
                            ),
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.caretDown,
                              size: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.v16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size32,
                  ),
                  child: Text(
                    "All highlights and where to watch live matches on FIFA+ I wonder how to it would look",
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: Sizes.size12,
                    ),
                    Gaps.h4,
                    Text(
                      "https://nomadcoders.co",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gaps.v20,
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: FaIcon(Icons.grid_4x4_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopCount extends StatelessWidget {
  final String count;
  final String label;

  const PopCount({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
