import 'package:flutter/material.dart';

import 'light_color_constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // colorScheme: ColorScheme.light(
    //
    // ),
    primaryColor: LightColorConstant.primaryColor,
    secondaryHeaderColor: LightColorConstant.secondaryHeaderColor,
    primaryColorLight: LightColorConstant.buttonTextColor,
    scaffoldBackgroundColor: LightColorConstant.scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColorConstant.inputDecorationFillColor,
      centerTitle: true,
      foregroundColor: LightColorConstant.textPrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: LightColorConstant.textPrimaryColor,
        fontWeight: FontWeight.w700,
      ),
      scrolledUnderElevation: 0,
    ),
    // switchTheme: SwitchThemeData(
    //   trackColor: WidgetStateProperty.resolveWith<Color>((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return Color(0xFF15B86C);
    //     }
    //     return Colors.white;
    //   }),
    //   thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return Colors.white;
    //     }
    //     return Color(0xFF9E9E9E);
    //   }),
    //   trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return Colors.transparent;
    //     }
    //     return Color(0xFF9E9E9E);
    //   }),
    //   trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return 0;
    //     }
    //     return 2;
    //   }),
    // ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: LightColorConstant.primaryColor,
        foregroundColor: LightColorConstant.buttonTextColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightColorConstant.primaryColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        color: LightColorConstant.primaryDarkGreyColor,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        color: LightColorConstant.textSecondaryColor,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        color: LightColorConstant.primaryColor,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        color: LightColorConstant.primaryMediumGreyColor,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: LightColorConstant.textPrimaryColor,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: LightColorConstant.textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: LightColorConstant.textSecondaryColor,
        fontWeight: FontWeight.w400
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightColorConstant.inputDecorationFillColor,
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: LightColorConstant.textSecondaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColorConstant.inputDecorationFillColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColorConstant.inputDecorationFillColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: LightColorConstant.inputDecorationFillColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
      ),
    ),
    //   progressIndicatorTheme: ProgressIndicatorThemeData(
    //     color: Color(0xFF15B86C),
    //     circularTrackColor: Color(0xFF9E9E9E),
    //     strokeWidth: 4,
    //   ),
    //   checkboxTheme: CheckboxThemeData(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    //     side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    //     checkColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
    //     fillColor: WidgetStateProperty.resolveWith<Color>((states) {
    //       if (states.contains(WidgetState.selected)) {
    //         return Color(0xFF15B86C);
    //       }
    //       return Color(0xFFFFFFFF);
    //     }),
    //   ),
    //   floatingActionButtonTheme: FloatingActionButtonThemeData(
    //     backgroundColor: Color(0xFF15B86C),
    //     foregroundColor: Color(0xFFFFFCFC),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //     extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    //   ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: LightColorConstant.primaryColor,
        selectionColor: LightColorConstant.primaryColor.withValues(alpha: 0.5),
        selectionHandleColor: LightColorConstant.primaryColor,
      ),
    //   listTileTheme: ListTileThemeData(
    //     contentPadding: EdgeInsets.zero,
    //     titleTextStyle: TextStyle(
    //       color: Color(0xFF161F1B),
    //       fontWeight: FontWeight.w400,
    //       fontSize: 16,
    //     ),
    //     iconColor: Color(0xFF3A4640),
    //   ),
    //   dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: LightColorConstant.scaffoldBackgroundColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: LightColorConstant.primaryColor,
      unselectedItemColor: LightColorConstant.textSecondaryColor,
      showSelectedLabels: true,
    ),
    //   splashFactory: NoSplash.splashFactory,
    //   popupMenuTheme: PopupMenuThemeData(
    //     color: Color(0xFFFFFFFF),
    //     shape: RoundedRectangleBorder(
    //       side: BorderSide(color: Color(0xFFD1DAD6), width: 0.7),
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     elevation: 3,
    //     shadowColor: Color(0xFFD1DAD6),
    //     textStyle: TextStyle(
    //       fontSize: 20,
    //       fontWeight: FontWeight.w400,
    //       color: Color(0xFF161F1B),
    //     ),
    //   ),
  );
}
