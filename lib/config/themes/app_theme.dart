import 'package:flutter/material.dart';

import 'app_colors.dart';
import './app_text_styles.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme() => ThemeData.light(useMaterial3: true).copyWith(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // colorScheme: AppColors.lightColorScheme,
        textTheme: textTheme,
        // iconTheme: const IconThemeData(
        //   color: Color(0xff0F1340),
        // ),
        inputDecorationTheme: inputDecorationTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
      );

  static TextTheme textTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: const TextStyle(
      color: AppColors.b50,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 10,
    ),
    constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.g75,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.g75,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.p300,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.error,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    ),
  );

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: const ButtonStyle().copyWith(
      backgroundColor: WidgetStateColor.resolveWith(
        (state) {
          if (state.contains(WidgetState.disabled)) {
            return AppColors.p75;
          } else if (state.contains(WidgetState.hovered)) {
            return AppColors.p200;
          }
          return AppColors.p300;
        },
      ),
      foregroundColor: WidgetStateColor.resolveWith((_) => AppColors.w50),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maximumSize: WidgetStateProperty.all(
        const Size(double.infinity, 44),
      ),
    ),
  );

  static final OutlinedButtonThemeData outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: const ButtonStyle().copyWith(
      side: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.disabled)) {
          return const BorderSide(color: AppColors.p75);
        } else if (state.contains(WidgetState.hovered)) {
          return const BorderSide(color: AppColors.p200);
        }
        return const BorderSide(color: AppColors.p300);
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      foregroundColor: WidgetStateColor.resolveWith(
        (state) {
          if (state.contains(WidgetState.disabled)) {
            return AppColors.p75;
          } else if (state.contains(WidgetState.hovered)) {
            return AppColors.p200;
          }
          return AppColors.p300;
        },
      ),
    ),
  );
}
