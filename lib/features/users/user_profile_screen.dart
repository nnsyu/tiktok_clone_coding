import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/user_info_edit_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tabbar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  void _onPencilPressed() {
    context.pushNamed(UserInfoEditScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) {
            return Scaffold(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              body: SafeArea(
                child: DefaultTabController(
                  initialIndex: widget.tab == "likes" ? 1 : 0,
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          centerTitle: true,
                          title: Text(data.name),
                          actions: [
                            IconButton(
                              onPressed: _onPencilPressed,
                              icon: FaIcon(
                                FontAwesomeIcons.pencil,
                                size: Sizes.size20,
                              ),
                            ),
                            IconButton(
                              onPressed: _onGearPressed,
                              icon: FaIcon(
                                FontAwesomeIcons.gear,
                                size: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > Breakpoints.lg) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: Sizes.size24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Gaps.v20,
                                          Avatar(
                                            name: data.name,
                                            hasAvatar: data.hasAvatar,
                                            uid: data.uid,
                                          ),
                                          Gaps.v16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '@${data.name}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Sizes.size18,
                                                ),
                                              ),
                                              Gaps.h3,
                                              FaIcon(
                                                FontAwesomeIcons
                                                    .solidCircleCheck,
                                                size: Sizes.size16,
                                                color:
                                                    Colors.lightBlue.shade200,
                                              ),
                                            ],
                                          ),
                                          Gaps.v16,
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                        ],
                                      ),
                                      Gaps.h20,
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth * 0.4,
                                        ),
                                        child: Column(
                                          children: [
                                            FractionallySizedBox(
                                              widthFactor: 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                              Sizes.size3),
                                                        ),
                                                      ),
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          'Follow',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                Sizes.size16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
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
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            Sizes.size3),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .youtube,
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
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            Sizes.size3),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .caretDown,
                                                        size: Sizes.size16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gaps.v20,
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth:
                                                    constraints.maxWidth * 0.3,
                                              ),
                                              child: Text(
                                                "All highlights and where to watch live matches on FIFA+ I wonder how to it would look",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Gaps.v14,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Column(
                                  children: [
                                    Gaps.v20,
                                    Avatar(
                                      name: data.name,
                                      hasAvatar: data.hasAvatar,
                                      uid: data.uid,
                                    ),
                                    Gaps.v16,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '@${data.name}',
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                    Gaps.v16,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size32,
                                      ),
                                      child: Text(
                                        data.bio,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Gaps.v14,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.link,
                                          size: Sizes.size12,
                                        ),
                                        Gaps.h4,
                                        Text(
                                          data.link,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gaps.v20,
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: PersistentTabbar(),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        GridView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: 20,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width > Breakpoints.md ? 5 : 2,
                            crossAxisSpacing: Sizes.size2,
                            mainAxisSpacing: Sizes.size2,
                            childAspectRatio: 9 / 13,
                          ),
                          itemBuilder: (context, index) => Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 9 / 13,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/sample_image.jpg",
                                        image:
                                            "https://images.unsplash.com/photo-1566895291281-ea63efd4bdbc?q=80&w=2127&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      left: 1,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.play_arrow_outlined,
                                            color: Colors.white,
                                            size: Sizes.size18,
                                          ),
                                          Gaps.h3,
                                          Text(
                                            "4.1",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizes.size16,
                                            ),
                                          ),
                                          Gaps.h3,
                                          Text(
                                            "M",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizes.size16,
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
                        ),
                        Center(
                          child: Text(
                            'Page two',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
