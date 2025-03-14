import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import 'widgets/deposit_money_tab.dart';
import 'widgets/withdraw_money_tab.dart';

class QuickActionsView extends StatefulWidget {
  const QuickActionsView({super.key, required this.index});
  final int? index;

  @override
  State<QuickActionsView> createState() => _QuickActionsViewState();
}

class _QuickActionsViewState extends State<QuickActionsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.index ?? 0,
      length: 3,
      vsync: this,
    );
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
        text: 'Quick Action',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can either deposit, lock, unlock and/or withdraw your money here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(40),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.symmetric(
                vertical: 6,
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
                  text: 'Deposit Money',
                ),
                Tab(
                  text: 'Unlock Money',
                ),
                Tab(
                  text: 'Withdraw Money',
                ),
              ],
            ),
            const Height(30),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  DepositMoneyTab(),
                  ColoredBox(color: Colors.blue),
                  WithdrawMoneyTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
