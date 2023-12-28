import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController();
  late final TabController _tabController;

  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands"
  ];

  void _onSearchChanged(String value) {
    print("onSearchChanged : $value");
  }

  void _onSearchSubmitted(String value) {
    print("onSearchSubmitted : $value");
  }

  void _onClearClick() {
    print('onClearClick !!');
    //FocusScope.of(context).unfocus();
    _textEditingController.clear();
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() => FocusScope.of(context).unfocus());

    // _tabController.addListener((){
    //   if(_tabController.indexIsChanging) {
    //     FocusScope.of(context).unfocus();
    //   }
    // });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("width : $width");

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Breakpoints.sm
            ),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.arrowLeft,
                ),
                Gaps.h20,
                Flexible(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      // isDense: true,
                      // contentPadding: EdgeInsets.zero,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: Sizes.size14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                      ),
                      suffix: GestureDetector(
                        onTap: _onClearClick,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          size: Sizes.size20,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.size12,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Sizes.size12,
                        vertical: Sizes.size10,
                      ),
                    ),
                  ),
                ),
                Gaps.h10,
                Icon(
                  Icons.tune,
                  size: Sizes.size28,
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size6,
            ),
            splashFactory: NoSplash.splashFactory,
            // overlayColor: MaterialStateProperty.resolveWith<Color?>(
            //       (Set<MaterialState> states) {
            //     return states.contains(MaterialState.focused)
            //         ? null
            //         : Colors.grey.shade100;
            //   },
            // ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.md ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 21,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              Sizes.size5,
                            ),
                          ),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/sample_image.jpg",
                          image:
                          "https://images.unsplash.com/photo-1566895291281-ea63efd4bdbc?q=80&w=2127&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "${constraints.maxWidth} This is a very long caption for my tiktok that im upload just now currently.",
                      style: const TextStyle(
                        fontSize: Sizes.size16 + Sizes.size1,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    if(constraints.maxWidth < 200 || constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  NetworkImage("https://avatars.githubusercontent.com/u/34337539?v=4"),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                "My avatar is is going to very long",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                // style: TextStyle(
                                //   fontWeight: FontWeight.w500,
                                //   color: Colors.grey.shade600,
                                // ),
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            Text(
                              "2.5M",
                              // style: TextStyle(
                              //   fontWeight: FontWeight.w500,
                              //   color: Colors.grey.shade600,
                              // ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
