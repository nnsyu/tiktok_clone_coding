import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  bool _onDismissed(DismissDirection direction) {
    if(direction == DismissDirection.startToEnd) {
      print('Check !!');
    } else if (direction == DismissDirection.endToStart){
      print('Delete !!');
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Activity'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20,),
            child: Text(
              'New',
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          Gaps.v14,
          Dismissible(
            onDismissed: _onDismissed,
            key: const Key("x"),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Sizes.size10,
                ),
                child: FaIcon(
                  FontAwesomeIcons.checkDouble,
                  color: Colors.white,
                  size: Sizes.size20,
                ),
              ),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.only(
                  right: Sizes.size10,
                ),
                child: FaIcon(
                  FontAwesomeIcons.trashCan,
                  color: Colors.white,
                  size: Sizes.size20,
                ),
              ),
            ),
            child: ListTile(
              leading: Container(
                width: Sizes.size52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: Sizes.size1,
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "Account updates: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: Sizes.size14,
                        ),
                        children: [
                          TextSpan(
                            text: "Upload longer videos ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.size14,
                            ),
                          ),
                          TextSpan(
                            text: "1h",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.h16,
                ],
              ),
              trailing: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
