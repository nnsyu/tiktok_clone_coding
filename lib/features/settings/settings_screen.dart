import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/app_configuration/common_config.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  // bool _notifications = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                // SwitchListTile.adaptive(
                //   value: context.watch<PlaybackConfigViewModel>().muted,
                //   onChanged: (value) => context.read<PlaybackConfigViewModel>().setMuted(value),
                //   title: Text(
                //     config.isDarkMode ? "Dark Mode" : "Light Mode",
                //   ),
                //   subtitle: Text(
                //     "Videos muted by default",
                //   ),
                //   activeColor: Theme.of(context).primaryColor,
                // ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).autoplay,
                  onChanged: (value) =>
                      ref.read(playbackConfigProvider.notifier).setAutoplay(value),
                  title: Text(
                    "Auto Play",
                  ),
                  subtitle: Text(
                    "Videos auto play by default",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).muted,
                  onChanged: (value) =>
                      ref.read(playbackConfigProvider.notifier).setMuted(value),
                  title: Text(
                    "Auto Mute",
                  ),
                  subtitle: Text(
                    "Videos muted by default",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                SwitchListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: Text(
                    "Enable notifications",
                  ),
                  subtitle: Text(
                    "They will be cute",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                CheckboxListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: Text(
                    "Enable notifications",
                  ),
                  activeColor: Theme.of(context).primaryColor,
                ),
                ListTile(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    if (kDebugMode) {
                      print(date);
                    }

                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }

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
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
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
                  applicationLegalese:
                      "All rights reserved. Please don't copy me.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
