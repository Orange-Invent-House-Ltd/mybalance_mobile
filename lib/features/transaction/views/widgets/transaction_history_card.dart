import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/routes/route_name.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/extensions/num_extension.dart';
import '../../../../core/shared/widgets/sizedbox.dart';
import '../../model/transaction_status.dart';
import './status_tooltip.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({
    super.key,
    required this.id,
    required this.refId,
    required this.status,
    required this.title,
    required this.price,
    required this.description,
    required this.dateTime,
  });
  final String id;
  final String refId;
  final TransactionStatus status;
  final String title;
  final double price;
  final String description;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context
          .pushNamed(RouteName.transactionDetails, queryParameters: {'id': id}),
      child: Card(
        elevation: 3,
        color: AppColors.w50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20.5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Trans. Ref: $refId',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.g100,
                        ),
                      ),
                      const Width(8),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: refId));
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Copied to Clipboard: $refId')),
                          );
                        },
                        child: SvgPicture.asset(AppAssets.copy),
                      )
                    ],
                  ),
                  StatusTooltip(status: status),
                ],
              ),
              const Height(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: status == TransactionStatus.inProgress
                          ? AppColors.g100
                          : AppColors.g400,
                    ),
                  ),
                  Text(
                    price.toCurrency(),
                    style: textTheme.titleMedium?.copyWith(
                      color: status == TransactionStatus.inProgress
                          ? AppColors.g100
                          : AppColors.g400,
                    ),
                  ),
                ],
              ),
              const Height(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 186.w,
                    child: Text(
                      description,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        color: status == TransactionStatus.inProgress
                            ? AppColors.g100
                            : AppColors.g400,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    _formartDateTime(dateTime),
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.g100,
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

  String _formartDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y h:mm a').format(dateTime);
  }
}
