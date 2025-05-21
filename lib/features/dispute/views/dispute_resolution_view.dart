import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../../../core/utils/date_format.dart';
import '../logic/dispute_notifier.dart';
import '../models/dispute.dart';
import '../models/dispute_resolution_status.dart';
import './widgets/dispute_status_tooltip.dart';
import 'provider/dispute_provider.dart';

class DisputeResolutionView extends ConsumerWidget {
  const DisputeResolutionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final disputeState = ref.watch(disputeNotifierProvider);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Dispute Resolution',
      ),
      body: Builder(
        builder: (context) {
          if (disputeState.status == DisputeStatuss.loading &&
              disputeState.disputes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (disputeState.status == DisputeStatuss.error &&
              disputeState.disputes.isEmpty) {
            return const Center(child: Text('Unable to load disputes'));
          }

          if (disputeState.disputes.isEmpty) {
            return const EmptyDispute();
          }
          return NotEmptyDispute(
            disputes: disputeState.disputes,
          );
        },
      ),
      // body: disputes.when(
      //   data: (data) => data.isEmpty
      //       ? const EmptyDispute()
      //       : NotEmptyDispute(disputes: data),
      //   error: (_, __) => const Center(
      //     child: Text('Unable to load disputes'),
      //   ),
      //   loading: () => const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }
}

class NotEmptyDispute extends StatelessWidget {
  const NotEmptyDispute({super.key, required this.disputes});
  final List<Dispute> disputes;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage disputes with vendors by creating a dispute thread here.',
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
          ),
          const Height(34),
          ...List.generate(
            disputes.length,
            (index) {
              final dispute = disputes[index];
              return DisputeResolutionCard(dispute: dispute);
            },
            growable: false,
          ),
          const Height(84),
        ],
      ),
    );
  }
}

class DisputeResolutionCard extends StatelessWidget {
  const DisputeResolutionCard({
    super.key,
    required this.dispute,
  });

  final Dispute dispute;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Card(
      color: AppColors.w50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: () => context.pushNamed(
          RouteName.disputeResolutionChat,
          pathParameters: {'id': dispute.id},
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.45,
                    child: Text(
                      dispute.reason,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.g500.withAlpha(
                          (dispute.status == DisputeStatus.resolved
                                  ? 255.0 * .4
                                  : 255.0 * 1)
                              .round(),
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DisputeStatusTooltip(status: dispute.status),
                ],
              ),
              const Height(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.45,
                    child: Text(
                      dispute.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.g500.withAlpha(
                          (dispute.status == DisputeStatus.resolved
                                  ? 255.0 * .4
                                  : 255.0 * 1)
                              .round(),
                        ),
                        fontSize: 13.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    FormatDate.monthDayYear(dispute.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.g300.withAlpha(
                        (dispute.status == DisputeStatus.resolved
                                ? 255.0 * .4
                                : 255.0 * 1)
                            .round(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyDispute extends StatelessWidget {
  const EmptyDispute({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Manage disputes with vendors by creating a dispute thread here.',
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
          ),
          Height(size.height * .15),
          SvgPicture.asset(
            AppAssets.empty,
            width: size.width,
          ),
          const Height(12),
          Text(
            'Oops! It seems that no dispute has been raised yet.',
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
          ),
        ],
      ),
    );
  }
}
