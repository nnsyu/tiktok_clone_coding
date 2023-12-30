import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _notificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
      if (kDebugMode) {
        print(_notifications);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale("ko"),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Settings'),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: ListView(
              children: [
                SwitchListTile.adaptive(
                  value: _notifications,
                  onChanged: _notificationChanged,
                  title: Text(
                    "Enable notifications",
                  ),
                  subtitle: Text(
                    "Enable notifications",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                CheckboxListTile.adaptive(
                  value: _notifications,
                  onChanged: _notificationChanged,
                  title: Text(
                    "Enable notifications",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                ListTile(
                  onTap: () async {
      
                    if(!mounted) return;
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    if (kDebugMode) {
                      print(date);
                    }
      
                    if(!mounted) return;
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }
      
                    if(!mounted) return;
                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          child: child!,
                          data: ThemeData(
                            appBarTheme: AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      },
                    );
                    if (kDebugMode) {
                      print(booking);
                    }
                  },
                  title: Text(
                    "What is your birthday?",
                  ),
                ),
                ListTile(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Are you sure?"),
                        content: Text("Please don't go"),
                        actions: [
                          CupertinoDialogAction(
                            child: Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: Text("Yes"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(
                    "Logout (IOS)",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Are you sure?"),
                        content: Text("Please don't go"),
                        actions: [
                          TextButton(
                            child: Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(
                    "Logout (Android)",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: Text("Are you sure?"),
                        message: Text("Please don't gooooo"),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Not Logout"),
                            isDefaultAction: true,
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Yes Please"),
                            isDestructiveAction: true,
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(
                    "Logout (IOS / Bottom)",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                AboutListTile(
                  applicationVersion: "1.0",
                  applicationLegalese: "All rights reserved. Please don't copy me.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
