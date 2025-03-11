import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Height extends StatelessWidget {
  const Height(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}

class Width extends StatelessWidget {
  const Width(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width.w);
  }
}

class FullWidth extends StatelessWidget {
  const FullWidth({
    super.key,
    this.height,
    this.child,
  });
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height?.h,
      child: child,
    );
  }
}

class AppSizedBox extends StatelessWidget {
  const AppSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      width: width?.w,
      height: height?.h,
      child: child,
    );
  }
}
