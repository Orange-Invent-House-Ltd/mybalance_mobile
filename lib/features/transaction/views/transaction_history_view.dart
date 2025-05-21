import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybalanceapp/features/transaction/model/transaction_type.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../model/transaction_model.dart';
import './widgets/transaction_history_card.dart';
import 'provider/transaction_provider.dart';

class TransactionHistoryView extends ConsumerStatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  ConsumerState<TransactionHistoryView> createState() =>
      _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends ConsumerState<TransactionHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final transactions = ref.watch(notifierProvider);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Transaction History',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'You can view an endless list of transactions you have transacted over time.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.g500,
                  ),
                ),
                const Height(19),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.p500,
                  indicator: const BoxDecoration(
                    color: AppColors.p50,
                    border: Border(
                      bottom: BorderSide(color: AppColors.p500, width: 2),
                    ),
                  ),
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.p500,
                  ),
                  unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.g200,
                  ),
                  tabs: const [
                    Tab(
                      text: 'All transactions',
                    ),
                    Tab(
                      text: 'Deposits',
                    ),
                    Tab(
                      text: 'Escrows',
                    ),
                    Tab(
                      text: 'Withdrawals',
                    ),
                  ],
                ),
              ],
            ),
            transactions.when(
              data: (data) => Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TransactionHistoryList(transactions: data),
                    TransactionHistoryList(
                        transactions: data
                            .where((e) => e.type == TransactionType.deposit)
                            .toList()),
                    TransactionHistoryList(
                        transactions: data
                            .where((e) => e.type == TransactionType.escrow)
                            .toList()),
                    TransactionHistoryList(
                        transactions: data
                            .where((e) => e.type == TransactionType.withdrawal)
                            .toList()),
                  ],
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading history'),
            ),
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       TransactionHistoryList(transactions: trans),
            //       TransactionHistoryList(transactions: trans),
            //       const TransactionHistoryList(transactions: []),
            //       TransactionHistoryList(transactions: trans),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({
    super.key,
    required this.transactions,
  });
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return transactions.isNotEmpty
        ? ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemCount: transactions.length,
            itemBuilder: (_, index) {
              final Transaction transaction = transactions[index];
              return TransactionHistoryCard(
                id: transaction.id,
                refId: transaction.reference,
                status: transaction.status,
                title: transaction.meta.title,
                price: transaction.amount,
                description: transaction.narration ?? '',
                dateTime: transaction.createdAt,
                isLoading: false,
              );
            },
            separatorBuilder: (_, index) => const Height(12),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.empty),
                const Height(16),
                Text(
                  'No recent activity',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.g200,
                  ),
                ),
                const Height(8),
                Text(
                  'Sorry, but it seems your transaction history is currently empty. ',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.g200,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
  }
}
