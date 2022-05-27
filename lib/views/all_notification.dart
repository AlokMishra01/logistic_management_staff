import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart' as colors;
import '../constants/values.dart' as values;
import '../controllers/notification_controller.dart';
import '../widgets/header.dart';

class AllNotification extends StatelessWidget {
  const AllNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationController>();
    notifications.getNotifications();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(
              backButton: true,
              title: 'Notifications',
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => notifications.getNotifications(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: values.BASE_PADDING,
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notifications.notifications.length,
                  // itemCount: 2,
                  itemBuilder: (_, i) {
                    final n = notifications.notifications[i];
                    return Container(
                      padding: const EdgeInsets.all(values.BASE_PADDING),
                      decoration: BoxDecoration(
                        color: colors.TEXT_WHITE,
                        borderRadius: BorderRadius.circular(
                          values.RADIUS,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CachedNetworkImage(
                          //   imageUrl: n.image ?? '',
                          // ),
                          // const SizedBox(height: 4.0),
                          Text(
                            n.title ?? '',
                            style: const TextStyle(
                              fontSize: values.TITLE_TEXT,
                              color: colors.TEXT_BLACK,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            n.description ?? '',
                            style: const TextStyle(
                              fontSize: values.TITLE_TEXT,
                              color: colors.TEXT_SECONDARY,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, i) {
                    return const SizedBox(height: values.BASE_PADDING / 2);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
