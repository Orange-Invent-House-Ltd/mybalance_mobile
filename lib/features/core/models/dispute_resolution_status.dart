import 'dart:ui';

enum DisputeResolutionStatus {
  resolved('Resolved', Color(0xff047857), Color(0xffDCFCE7)),
  inProgress('In progress', Color(0xff1D4ED8), Color(0xffDBEAFE)),
  pending('Pending', Color(0xffB45309), Color(0xffFEF3CF));

  const DisputeResolutionStatus(
    this.name,
    this.backgroundColor,
    this.foregroundColor,
  );
  final String name;
  final Color foregroundColor;
  final Color backgroundColor;
}
