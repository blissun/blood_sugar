import 'package:blood_sugar/theme/colors/colors.dart';
import 'package:flutter/material.dart';

class GraphTheme {
  static const defaultFontfamily = 'Pretendard';
  static final defaultTextTheme = ThemeData.light().textTheme.apply(
        fontFamily: defaultFontfamily,
      );
  static const detail2 = TextStyle(
    color: GraphColors.rightTitlesColor,
    fontSize: 12,
    height: 16.6,
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontfamily,
  );

  static ThemeData get light => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        textTheme: defaultTextTheme,
      );

  static ThemeData get dark => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        textTheme: defaultTextTheme,
      );
}
