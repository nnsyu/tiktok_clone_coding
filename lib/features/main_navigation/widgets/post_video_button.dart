import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(
        milliseconds: 100,
      ),
      curve: Curves.fastOutSlowIn,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 19,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              height: isSelected ? 35 : 32,
              width: isSelected ? 28 : 25,
              decoration: BoxDecoration(
                color: const Color(0xFF61D4F0),
                borderRadius: BorderRadius.circular(
                  Sizes.size10,
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8,
              ),
              height: isSelected ? 35 : 32,
              width: isSelected ? 28 : 25,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  Sizes.size10,
                ),
              ),
            ),
          ),
          Container(
            height: isSelected ? 35 : 32,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: 17,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 0.4,
                  ),
                  Shadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 0.4,
                  ),
                  Shadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 0.4,
                  ),
                  Shadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 0.4,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
