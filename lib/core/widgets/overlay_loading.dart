import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class OverlayLoading extends StatefulWidget {
  const OverlayLoading({
    super.key,
    required this.isLoading,
    required this.child,
    this.text,
  });
  final bool isLoading;
  final Widget child;
  final String? text;

  @override
  State<OverlayLoading> createState() => _OverlayLoadingState();
}

class _OverlayLoadingState extends State<OverlayLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OverlayLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }
    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        widget.child,
        FadeTransition(
          opacity: _animation,
          child: widget.isLoading
              ? Stack(
                  children: [
                    ModalBarrier(
                      dismissible: false,
                      color: AppColors.w50.withAlpha((255.0 * 0.6).round()),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoActivityIndicator(
                          radius: 20.0,
                          color: AppColors.p300,
                        ),
                        const SizedBox(
                          height: 24.0,
                          width: double.infinity,
                        ),
                        Text(
                          widget.text ?? 'Loading! Please wait...',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.b300),
                        ),
                        SizedBox(
                          height: size.height * 0.20,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
