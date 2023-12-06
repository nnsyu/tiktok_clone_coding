import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final VoidCallback onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: AnimatedOpacity(
          duration: const Duration(
            milliseconds: 200,
          ),
          opacity: isSelected ? 1 : 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                isSelected ? selectedIcon : icon,
                color: selectedIndex == 0 ? Colors.white : Colors.black,
              ),
              Gaps.v5,
              Text(
                text,
                style: TextStyle(
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
