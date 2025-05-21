import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/features/transaction/model/transaction_model.dart';
import 'package:mybalanceapp/features/transaction/views/widgets/transaction_history_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/shared/widgets/app_drawer.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../../../core/utils/date_format.dart';
import '../../profile/views/provider/profile_provider.dart';
import '../../transaction/views/provider/transaction_provider.dart';
import '../../wallet/model/wallet.dart';
import '../../wallet/view/wallet_providers.dart';
import './provider/view_providers.dart';
import './widgets/amount_card.dart';
import './widgets/our_charges_card.dart';
import './widgets/quick_action_card.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider).maybeWhen(
        orElse: () {
          log('Name not found');
          return '';
        },
        data: (name) => '$name!');

    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    final profile = ref.watch(readProfileProvider);
    final wallet = ref.watch(readWalletProvider);
    wallet.maybeWhen(
      orElse: () {
        log('Profile not found');
      },
      data: (data) {
        log(data.first.createdAt.toString());
      },
      error: (error, _) {
        log(error.toString());
      },
    );

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
              TextSpan(
                text: 'Welcome ',
                style: const TextStyle(color: AppColors.b100),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(
                      color: AppColors.b300,
                    ),
                  ),
                ],
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Height(8),
            AppBoxShimmer(
              width: size.width * 0.75,
              height: 20,
              borderRadius: BorderRadius.circular(6),
              isLoading: profile.isLoading,
              withContainer: true,
              child: profile.when(
                data: (data) {
                  if (data.lastLoginDate == null) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    'Your last login was on ${FormatDate.mmddyyyyHhmmss(data.lastLoginDate!)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.g500,
                    ),
                  );
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
              ),
            ),
            const Height(8),
            AppBoxShimmer(
              width: size.width * 0.7,
              height: 25,
              isLoading: profile.isLoading,
              borderRadius: BorderRadius.circular(15),
              child: profile.when(
                data: (data) {
                  if (data.freeEscrowTransactions > 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
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
                    );
                  }
                  return const SizedBox.shrink();
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
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
                    height: 35.h,
                    width: 95.w,
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
              height: 94.h,
              child: wallet.when(
                data: (data) {
                  final Wallet nigeriaWallet = data.firstWhere(
                    (element) => element.currency == 'NGN',
                  );
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 20),
                    children: [
                      AmountCard(
                        title: 'Available balance in escrow',
                        amount: nigeriaWallet.balance,
                        isLoading: false,
                      ),
                      const Width(20),
                      AmountCard(
                        title: 'Total amount locked',
                        amount: nigeriaWallet.lockedAmountInward,
                        isLoading: false,
                      ),
                      const Width(20),
                      AmountCard(
                        title: 'Total amount withdrawn',
                        amount: nigeriaWallet.withdrawnAmount,
                        isLoading: false,
                      ),
                      const Width(20),
                    ],
                  );
                },
                error: (e, __) {
                  log(e.toString());
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 20),
                    children: const [
                      AmountCard(
                        title: 'Available balance in escrow',
                        amount: 0,
                        isLoading: true,
                      ),
                      Width(20),
                      AmountCard(
                        title: 'Total amount locked',
                        amount: 0,
                        isLoading: true,
                      ),
                      Width(20),
                      AmountCard(
                        title: 'Total amount withdrawn',
                        amount: 0,
                        isLoading: true,
                      ),
                      Width(20),
                    ],
                  );
                },
                loading: () => ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 20),
                  children: const [
                    AmountCard(
                      title: 'Available balance in escrow',
                      amount: 0,
                      isLoading: true,
                    ),
                    Width(20),
                    AmountCard(
                      title: 'Total amount locked',
                      amount: 0,
                      isLoading: true,
                    ),
                    Width(20),
                    AmountCard(
                      title: 'Total amount withdrawn',
                      amount: 0,
                      isLoading: true,
                    ),
                    Width(20),
                  ],
                ),
              ),
            ),
            const Height(32),
            FullWidth(
              // width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteName.withdrawFunds);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.p500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Withdraw funds'),
              ),
            ),
            const Height(16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.p500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: AppColors.p500),
                  ),
                ),
                child: const Text('Share MyBalance link'),
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
                    fontSize: 18.sp,
                    color: AppColors.g200,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteName.transactionHistory),
                  style: TextButton.styleFrom(foregroundColor: AppColors.p300),
                  child: const Text('View all'),
                ),
              ],
            ),
            const Height(20),
            ref.watch(notifierProvider).when(
                  data: (dat) {
                    late List<Transaction> data;
                    if (dat.length >= 2) {
                      data = dat.sublist(0, 2);
                    } else if (dat.isNotEmpty) {
                      data = dat.sublist(0, dat.length);
                    } else {
                      data = [];
                    }
                    return Column(
                      children: data.map(
                        (transaction) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TransactionHistoryCard(
                                id: transaction.id,
                                refId: transaction.reference,
                                status: transaction.status,
                                title: transaction.meta.title,
                                price: transaction.amount,
                                description: transaction.narration ?? '',
                                dateTime: transaction.createdAt,
                                isLoading: false,
                              ),
                              const Height(12),
                            ],
                          );
                        },
                      ).toList(),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) {
                    log('transaction err: $e');
                    log('transaction st: $st');
                    return Center(
                      child: Text(
                        'Error fetching history',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  },
                ),
            const Height(20),
          ],
        ),
      ),
    );
  }
}

class AppBoxShimmer extends ConsumerWidget {
  const AppBoxShimmer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.isCircle = false,
    this.withContainer = false,
    this.baseColor,
    this.highlightColor,
  });
  final bool isLoading;
  final bool isCircle;
  final bool withContainer;
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: baseColor ?? AppColors.g50,
            highlightColor: highlightColor ?? Colors.white,
            child: !withContainer
                ? child
                : Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: AppColors.g50,
                      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius: borderRadius,
                    ),
                  ),
          )
        : child;
  }
}
