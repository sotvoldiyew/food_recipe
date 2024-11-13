import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: "Poppins",
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: "Poppins",
  );
}

/// Light [ColorScheme] made with FlexColorScheme v8.0.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // Selected
  primary: Color(0xff129575),
  primaryFixed:  Color(0xff36855e),
  secondaryContainer: Color(0xff71b1a1),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffebebeb),
  secondary:Color(0xffffad30),
  onSecondary: Color(0xffffe1b3),


  primaryFixedDim: Color(0xff8cd39d),
  onPrimaryFixed: Color(0xff000902),
  onPrimaryFixedVariant: Color(0xff001b07),
  onPrimaryContainer: Color(0xffffffff),
  onSecondaryContainer: Color(0xff000000),
  secondaryFixed: Color(0xffcfe7db),
  secondaryFixedDim: Color(0xffa7d0bb),
  onSecondaryFixed: Color(0xff122c1f),
  onSecondaryFixedVariant: Color(0xff173928),
  tertiary: Color(0xff00658c),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffc5e7ff),
  onTertiaryContainer: Color(0xff000000),
  tertiaryFixed: Color(0xffbfe1ef),
  tertiaryFixedDim: Color(0xff8cc5dd),
  onTertiaryFixed: Color(0xff00151e),
  onTertiaryFixedVariant: Color(0xff002230),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff000000),
  surface: Color(0xfffcfcfc),
  onSurface: Color(0xff111111),
  surfaceDim: Color(0xffe0e0e0),
  surfaceBright: Color(0xfffdfdfd),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff8f8f8),
  surfaceContainer: Color(0xfff3f3f3),
  surfaceContainerHigh: Color(0xffededed),
  surfaceContainerHighest: Color(0xffe7e7e7),
  onSurfaceVariant: Color(0xff393939),
  outline: Color(0xff919191),
  outlineVariant: Color(0xffd1d1d1),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2a2a2a),
  onInverseSurface: Color(0xfff1f1f1),
  inversePrimary: Color(0xff8edfa3),
  surfaceTint: Color(0xff006e1c),
);

/// Dark [ColorScheme] made with FlexColorScheme v8.0.0.
/// Requires Flutter 3.22.0 or later.
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff7edb7b),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xff005313),
  onPrimaryContainer: Color(0xffffffff),
  primaryFixed: Color(0xffbfe8c9),
  primaryFixedDim: Color(0xff8cd39d),
  onPrimaryFixed: Color(0xff000902),
  onPrimaryFixedVariant: Color(0xff001b07),
  secondary: Color(0xffa3f4c5),
  onSecondary: Color(0xff000000),
  secondaryContainer: Color(0xff003822),
  onSecondaryContainer: Color(0xffffffff),
  secondaryFixed: Color(0xffcfe7db),
  secondaryFixedDim: Color(0xffa7d0bb),
  onSecondaryFixed: Color(0xff122c1f),
  onSecondaryFixedVariant: Color(0xff173928),
  tertiary: Color(0xff87cffb),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xff004c6a),
  onTertiaryContainer: Color(0xffffffff),
  tertiaryFixed: Color(0xffbfe1ef),
  tertiaryFixedDim: Color(0xff8cc5dd),
  onTertiaryFixed: Color(0xff00151e),
  onTertiaryFixedVariant: Color(0xff002230),
  error: Color(0xffffb4ab),
  onError: Color(0xff000000),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffffff),
  surface: Color(0xff080808),
  onSurface: Color(0xfff1f1f1),
  surfaceDim: Color(0xff060606),
  surfaceBright: Color(0xff2c2c2c),
  surfaceContainerLowest: Color(0xff010101),
  surfaceContainerLow: Color(0xff0e0e0e),
  surfaceContainer: Color(0xff151515),
  surfaceContainerHigh: Color(0xff1d1d1d),
  surfaceContainerHighest: Color(0xff282828),
  onSurfaceVariant: Color(0xffcacaca),
  outline: Color(0xff777777),
  outlineVariant: Color(0xff414141),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe8e8e8),
  onInverseSurface: Color(0xff2a2a2a),
  inversePrimary: Color(0xff3c613b),
  surfaceTint: Color(0xff7edb7b),
);
