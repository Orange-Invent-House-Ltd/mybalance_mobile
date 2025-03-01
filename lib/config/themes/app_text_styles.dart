import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle? get displayLarge =>
      const TextTheme().displayLarge?.copyWith();
  static TextStyle? get displayMedium =>
      const TextTheme().displayMedium?.copyWith();
  static TextStyle? get displaySmall =>
      const TextTheme().displaySmall?.copyWith();

  static TextStyle? get headlineLarge =>
      const TextTheme().headlineLarge?.copyWith();
  static TextStyle? get headlineMedium =>
      const TextTheme().headlineMedium?.copyWith();
  static TextStyle? get headlineSmall =>
      const TextTheme().headlineSmall?.copyWith();

  static TextStyle? get titleLarge => const TextTheme().titleLarge?.copyWith();
  static TextStyle? get titleMedium =>
      const TextTheme().titleMedium?.copyWith();
  static TextStyle? get titleSmall => const TextTheme().titleSmall?.copyWith();

  static TextStyle? get labelLarge => const TextTheme().labelLarge?.copyWith();
  static TextStyle? get labelMedium =>
      const TextTheme().labelMedium?.copyWith();
  static TextStyle? get labelSmall => const TextTheme().labelSmall?.copyWith();

  static TextStyle? get bodyLarge => const TextTheme().bodyLarge?.copyWith();
  static TextStyle? get bodyMedium => const TextTheme().bodyMedium?.copyWith();
  static TextStyle? get bodySmall => const TextTheme().bodySmall?.copyWith();
}
