import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/breakpoints.dart';
import '../../../constants/sizes.dart';

class PersistentTabbar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => TabBar(
          tabAlignment: constraints.maxWidth > Breakpoints.sm ? TabAlignment.center : TabAlignment.fill,
          isScrollable: constraints.maxWidth > Breakpoints.sm ? true : false,
          splashFactory: NoSplash.splashFactory,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          tabs: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > Breakpoints.sm ? Sizes.size96 : Sizes.size20,
              ),
              child: FaIcon(Icons.grid_4x4_rounded),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > Breakpoints.sm ? Sizes.size96 : Sizes.size20,
              ),
              child: FaIcon(
                FontAwesomeIcons.heart,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
