import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final String content;
  final bool isCurrent;

  const TutorialPage({
    super.key,
    required this.title,
    required this.content,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isCurrent ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500,),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v80,
            Text(
              title,
              style: TextStyle(
                fontSize: Sizes.size40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v16,
            Text(
              content,
              style: TextStyle(
                fontSize: Sizes.size20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
