import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../../core/widgets/sizedbox.dart';
import '../models/models.dart';
import 'widgets/amount_card.dart';
import 'widgets/our_charges_card.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/transaction_history_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Jamjam';
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          IconButton.filled(
            onPressed: () => context.pushNamed(RouteName.notification),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.p50,
              foregroundColor: AppColors.p500,
            ),
            icon: const Icon(Icons.notifications_outlined),
          ),
          const Width(16),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              const TextSpan(
                text: 'Welcome ',
                style: TextStyle(color: AppColors.b100),
                children: [
                  TextSpan(
                    text: '$name!',
                    style: TextStyle(
                      color: AppColors.b300,
                    ),
                  ),
                ],
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Height(8),
            Text(
              'Your last login was on 01/12/2022 10:00:34 AM',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xffEBF4EC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You have 5 free escrow transactions',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: const Color(0xff2D7738)),
                  ),
                  const Width(6),
                  const Icon(
                    Icons.info,
                    color: Color(0xff2D7738),
                  ),
                ],
              ),
            ),
            const Height(32),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: AppColors.p50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create your MyBalance link.',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.b300,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 95,
                    child: ElevatedButton(
                      onPressed: () => context.goNamed(RouteName.createLink),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        textStyle: theme.textTheme.titleSmall,
                      ),
                      child: const Text('Create link'),
                    ),
                  )
                ],
              ),
            ),
            const Height(32),
            SizedBox(
              height: 94,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 20),
                children: const [
                  AmountCard(
                    title: 'Available balance in escrow',
                    amount: 30000,
                  ),
                  Width(20),
                  AmountCard(
                    title: 'Total amount locked',
                    amount: 10000,
                  ),
                  Width(20),
                  AmountCard(
                    title: 'Total amount unlocked',
                    amount: 0,
                  ),
                  Width(20),
                ],
              ),
            ),
            const Height(32),
            const OurChargesCard(),
            const Height(32),
            Text(
              'Quick actions',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.g200,
              ),
            ),
            const Height(20),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                QuickActionCard(
                  onTap: () => context.goNamed(
                    RouteName.quickAction,
                    queryParameters: <String, String>{'index': '0'},
                  ),
                  svgIcon: AppAssets.add,
                  title: 'Deposit money',
                  subTitle: 'Add money to your escrow wallet',
                ),
                QuickActionCard(
                  onTap: () => context.goNamed(
                    RouteName.quickAction,
                    queryParameters: <String, String>{'index': '1'},
                  ),
                  svgIcon: AppAssets.unlock,
                  title: 'Unlock money',
                  subTitle: 'Release the money in your wallet',
                ),
                QuickActionCard(
                  onTap: () => context.goNamed(
                    RouteName.quickAction,
                    queryParameters: <String, String>{'index': '2'},
                  ),
                  svgIcon: AppAssets.download,
                  title: 'Withdraw money',
                  subTitle: 'Withdraw your money from your wallet',
                ),
                QuickActionCard(
                  onTap: () {},
                  svgIcon: AppAssets.share,
                  title: 'Share link',
                  subTitle: 'Share your escrow information with everyone',
                ),
              ],
            ),
            const Height(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction history',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    color: AppColors.g200,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.goNamed(RouteName.transactionHistory),
                  style: TextButton.styleFrom(foregroundColor: AppColors.p300),
                  child: const Text('View all'),
                ),
              ],
            ),
            const Height(20),
            TransactionHistoryCard(
              refId: '20240528agyudnjhddh22',
              status: TransactionStatus.inProgress,
              title: 'White Air Jordans',
              price: 20000,
              description:
                  'Pair of white Air Jordans That is the best whatever',
              dateTime: DateTime.now(),
            ),
            const Height(12),
            TransactionHistoryCard(
              refId: '20240528agyudnjhddh22',
              status: TransactionStatus.pending,
              title: 'Apple Series 2',
              price: 10000,
              description:
                  'Apple series 2 smartwatch That is the best whatever',
              dateTime: DateTime.now(),
            ),
            const Height(32),
          ],
        ),
      ),
    );
  }
}
