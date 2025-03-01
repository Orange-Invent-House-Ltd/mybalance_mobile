import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/core/models/loading_from.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/sizedbox.dart';

class DepositMoneyView extends StatefulWidget {
  const DepositMoneyView({super.key});

  @override
  State<DepositMoneyView> createState() => _DepositMoneyViewState();
}

class _DepositMoneyViewState extends State<DepositMoneyView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Deposit Money',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can either choose between a transfer or pay with card.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(40),
            TabBar(
              controller: _tabController,
              labelStyle: theme.textTheme.titleMedium,
              labelColor: AppColors.p500,
              unselectedLabelStyle: theme.textTheme.bodyLarge,
              unselectedLabelColor: AppColors.g200,
              indicatorColor: AppColors.p500,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  text: 'Use a bank card',
                ),
                Tab(
                  text: 'Deposit via transfer',
                ),
              ],
            ),
            const Height(30),
            LabelTextField(
              controller: _amountController,
              label: 'Enter amount to deposit',
              hintText: 'e.g 10,000',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            const Height(16),
            SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: _amountController,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value.text.length < 4
                        ? null
                        : () {
                            if (_tabController.index == 1) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const DepositTransferDialog();
                                },
                              );
                            } else {
                              context.pushNamed(
                                RouteName.loading,
                                queryParameters: <String, String>{
                                  'loadingFrom': LoadingFrom.paymentStatus.name,
                                },
                              );
                            }
                          },
                    child: const Text('Continue'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DepositTransferDialog extends StatelessWidget {
  const DepositTransferDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.all(17.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppAssets.info),
            const Height(12),
            Text(
              'Dear Valued Buyer,',
              style: textTheme.titleMedium?.copyWith(color: AppColors.b300),
            ),
            const Height(4),
            Text.rich(
              TextSpan(
                text: 'When depositing funds using ',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.b200),
                children: [
                  TextSpan(
                    text: 'bank transfer',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.b200,
                    ),
                  ),
                  const TextSpan(
                    text: ', note that our third-party platform displays ',
                  ),
                  TextSpan(
                    text: '"MyBalance,"',
                    style:
                        textTheme.labelLarge?.copyWith(color: AppColors.b200),
                  ),
                  const TextSpan(text: ' while your bank app shows '),
                  TextSpan(
                    text: '"Orange Invent House Limited"',
                    style:
                        textTheme.labelLarge?.copyWith(color: AppColors.b200),
                  ),
                  const TextSpan(text: '  —both represent the same entity.')
                ],
              ),
            ),
            const Height(16),
            Text.rich(
              TextSpan(
                text: 'For concerns, contact ',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.b200),
                children: [
                  TextSpan(
                    text: 'customer support',
                    style:
                        textTheme.bodyMedium?.copyWith(color: AppColors.p300),
                  ),
                  const TextSpan(text: '.')
                ],
              ),
            ),
            const Height(16),
            Text(
              'Thank you for your understanding and trust.',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.b200),
            ),
            const Height(24),
            SizedBox(
              width: 167.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pushNamed(
                    RouteName.loading,
                    queryParameters: <String, String>{
                      'loadingFrom': LoadingFrom.paymentStatus.name,
                    },
                  );
                },
                child: const Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
