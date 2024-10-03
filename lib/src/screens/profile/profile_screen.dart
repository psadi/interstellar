import 'package:flutter/material.dart';
import 'package:interstellar/src/screens/profile/notification/notification_badge.dart';
import 'package:interstellar/src/screens/profile/notification/notification_screen.dart';
import 'package:interstellar/src/screens/profile/self_feed.dart';
import 'package:interstellar/src/screens/settings/settings_controller.dart';
import 'package:interstellar/src/utils/utils.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import './messages/messages_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return whenLoggedIn(
          context,
          context.read<SettingsController>().serverSoftware ==
                  ServerSoftware.lemmy
              ? const SelfFeed()
              : DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                          context.watch<SettingsController>().selectedAccount),
                      bottom: TabBar(tabs: [
                        Tab(
                          text: l(context).notifications,
                          icon: const NotificationBadge(
                              child: Icon(Symbols.notifications_rounded)),
                        ),
                        Tab(
                          text: l(context).messages,
                          icon: const Icon(Symbols.message_rounded),
                        ),
                        Tab(
                          text: l(context).profile_overview,
                          icon: const Icon(Symbols.person_rounded),
                        ),
                      ]),
                    ),
                    body: const TabBarView(children: [
                      NotificationsScreen(),
                      MessagesScreen(),
                      SelfFeed(),
                    ]),
                  ),
                ),
        ) ??
        Center(
          child: Text(l(context).notLoggedIn),
        );
  }
}
