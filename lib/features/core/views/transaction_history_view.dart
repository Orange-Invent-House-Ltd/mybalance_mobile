import 'package:flutter/material.dart';
import 'package:mybalanceapp/features/core/models/models.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/sizedbox.dart';
import 'widgets/transaction_history_card.dart';

class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView>
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
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Transaction History',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
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
                      fontSize: 13,
                      color: AppColors.p500,
                    ),
                    unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
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
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return TransactionHistoryCard(
                        refId: '20240528agyudnjhddh2$index',
                        status: TransactionStatus.inProgress,
                        title: 'Apple Series 2',
                        price: 10000,
                        description:
                            'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch ',
                        dateTime: DateTime.now(),
                      );
                    },
                    separatorBuilder: (_, index) => const Height(12),
                  ),
                  Center(
                    child: Text(
                      '${_tabController.index}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${_tabController.index}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${_tabController.index}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
