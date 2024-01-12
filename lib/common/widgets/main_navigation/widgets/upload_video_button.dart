import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class UploadVideoButton extends StatelessWidget {
  const UploadVideoButton({
    super.key,
    required this.isSelected,
    required this.inverted,
  });

  final bool isSelected;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: isSelected ? 22 : 19,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 100,
            ),
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
          left: isSelected ? 22 : 19,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 100,
            ),
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
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          height: isSelected ? 35 : 32,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 15 : Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: inverted || isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(
              Sizes.size10,
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted || isDark ? Colors.black : Colors.white,
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
    );
  }
}
