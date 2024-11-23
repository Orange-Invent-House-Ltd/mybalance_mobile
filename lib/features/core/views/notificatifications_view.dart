import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/sizedbox.dart';
import '../models/notification_model.dart';
import 'widgets/notification_card.dart';

class NotificatificationsView extends StatelessWidget {
  const NotificatificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    const unread = 1;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Notifications',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get instant notification as you perform real-time transaction immediately on MyBalance.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(40),
            if (notify.isEmpty)
              Text(
                'You have 0 unread notifications',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: AppColors.b300),
              )
            else ...[
              Text(
                'You have $unread unread notifications',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: AppColors.b300),
              ),
              const Height(32),
              Expanded(
                child: ListView.separated(
                  itemCount: notify.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  itemBuilder: (_, index) {
                    final notification = notify[index];
                    return NotificationCard(
                      title: notification.title,
                      description: notification.description,
                      isRead: notification.isRead,
                      timestamp: notification.timestamp,
                    );
                  },
                  separatorBuilder: (_, index) => const Height(12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
