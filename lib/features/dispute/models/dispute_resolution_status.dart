import 'dart:ui';

enum DisputeStatus {
  resolved('Resolved', Color(0xff047857), Color(0xffDCFCE7)),
  progress('In progress', Color(0xff1D4ED8), Color(0xffDBEAFE)),
  pending('Pending', Color(0xffB45309), Color(0xffFEF3CF)),
  rejected('Rejected', Color(0xffB45309), Color(0xffFEF3CF));

  const DisputeStatus(
    this.name,
    this.foregroundColor,
    this.backgroundColor,
  );
  final String name;
  final Color foregroundColor;
  final Color backgroundColor;
}
