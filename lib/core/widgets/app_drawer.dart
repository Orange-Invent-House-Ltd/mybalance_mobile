import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../config/routes/route_name.dart';
import '../../config/themes/app_colors.dart';
import '../../features/core/views/widgets/logout_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.b200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            DrawerListTile(
              onTap: Navigator.of(context).pop,
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Dashboard',
              selected: true,
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.quickAction);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Quick action',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.transactionHistory);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Transaction history',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.notification);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Notifications',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.profile);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'My profile',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.disputeResolution);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Dispute resolution',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(RouteName.quickAction);
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Settings',
            ),
            DrawerListTile(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const LogoutDialog(),
                );
              },
              leading: SvgPicture.asset('assets/icons/dashboard.svg'),
              title: 'Logout',
              textColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.onTap,
    this.leading,
    required this.title,
    this.selected = false,
    this.textColor,
  });
  final GestureTapCallback onTap;
  final Widget? leading;
  final String title;
  final bool selected;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: onTap,
      selected: selected,
      selectedColor: AppColors.p300,
      selectedTileColor: AppColors.w50,
      titleTextStyle: textTheme.titleMedium,
      textColor: textColor,
      leading: leading,
      hoverColor: AppColors.w500,
      title: Text(title),
    );
  }
}
