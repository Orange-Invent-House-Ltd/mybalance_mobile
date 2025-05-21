import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import './widgets/notification_card.dart';
import 'provider/notification_provider.dart';

class NotificatificationsView extends ConsumerWidget {
  const NotificatificationsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notify = ref.watch(notificationsProvider);
    const unread = 1;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Notifications',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: notify.when(
          data: (data) {
            return Column(
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
                if (data.isEmpty)
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
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      itemBuilder: (_, index) {
                        final notification = data[index];
                        return NotificationCard(
                          title: notification.title,
                          description: notification.content,
                          isRead: notification.isSeen,
                          timestamp: notification.createdAt,
                        );
                      },
                      separatorBuilder: (_, index) => const Height(12),
                    ),
                  ),
                ],
              ],
            );
          },
          error: (_, __) => const Text('Error loading Notifivations'),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Get instant notification as you perform real-time transaction immediately on MyBalance.',
        //       style: theme.textTheme.bodyMedium?.copyWith(
        //         color: AppColors.g500,
        //       ),
        //     ),
        //     const Height(40),
        //     if (notify.isEmpty)
        //       Text(
        //         'You have 0 unread notifications',
        //         style: theme.textTheme.titleMedium
        //             ?.copyWith(color: AppColors.b300),
        //       )
        //     else ...[
        //       Text(
        //         'You have $unread unread notifications',
        //         style: theme.textTheme.titleMedium
        //             ?.copyWith(color: AppColors.b300),
        //       ),
        //       const Height(32),
        //       Expanded(
        //         child: ListView.separated(
        //           itemCount: notify.length,
        //           padding:
        //               const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        //           itemBuilder: (_, index) {
        //             // final notification = notify[index];
        //             return NotificationCard(
        //               title: notification.title,
        //               description: notification.description,
        //               isRead: notification.isRead,
        //               timestamp: notification.timestamp,
        //             );
        //           },
        //           separatorBuilder: (_, index) => const Height(12),
        //         ),
        //       ),
        //     ],
        //   ],
        // ),
      ),
    );
  }
}
