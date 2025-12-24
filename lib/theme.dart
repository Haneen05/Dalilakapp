import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class DIcons {
  static const ImageIcon bookmark =
      ImageIcon(AssetImage('assets/icons/bookmark.png'));
  static const ImageIcon category =
      ImageIcon(AssetImage('assets/icons/category.png'));
  static const ImageIcon home = ImageIcon(AssetImage('assets/icons/home.png'));
  static const ImageIcon search =
      ImageIcon(AssetImage('assets/icons/search.png'));
  static const ImageIcon user = ImageIcon(AssetImage('assets/icons/user.png'));
  static const ImageIcon health =
      ImageIcon(AssetImage('assets/icons/health.png'));
  static const ImageIcon house =
      ImageIcon(AssetImage('assets/icons/house.png'));
  static const ImageIcon settings =
      ImageIcon(AssetImage('assets/icons/settings.png'));
  static const ImageIcon devices =
      ImageIcon(AssetImage('assets/icons/devices.png'));
  static const ImageIcon file = ImageIcon(AssetImage('assets/icons/file.png'));
  static const ImageIcon support =
      ImageIcon(AssetImage('assets/icons/support.png'));
  static const ImageIcon shoppingBag =
      ImageIcon(AssetImage('assets/icons/shopping_bag.png'));
  static const ImageIcon award =
      ImageIcon(AssetImage('assets/icons/award.png'));
  static const ImageIcon facebook =
      ImageIcon(AssetImage('assets/icons/facebook.png'));
  static const ImageIcon instagram =
      ImageIcon(AssetImage('assets/icons/instagram.png'));
  static const ImageIcon x = ImageIcon(AssetImage('assets/icons/x.png'));
  static const ImageIcon linkedin =
      ImageIcon(AssetImage('assets/icons/linkedin.png'));
  static const ImageIcon sortArrows =
      ImageIcon(AssetImage('assets/icons/sort_arrows.png'));
}

final interTextTheme = GoogleFonts.interTextTheme();

final dalilakThemeData = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xfff9da42),
    onPrimary: Color(0xff000000),
    secondary: Color(0xff000000),
    onSecondary: Color(0xffffffff),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    surface: Color(0xfff3f4f6),
    onSurface: Color(0xff000000),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xffbdbdbd),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xff000000),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xffe16060),
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xff870000),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xffc7c7c7),
      ),
    ),
    hintStyle: GoogleFonts.interTextTheme().bodySmall!.copyWith(
          fontWeight: FontWeight.normal,
          color: const Color(0xffc7c7c7),
          fontSize: 13.0,
        ),
    filled: false,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: Color(0xff020617),
    unselectedItemColor: Color(0xff94a3b8),
    type: BottomNavigationBarType.fixed,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xffe7e7e7),
      foregroundColor: const Color(0xff000000),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xfff9da42),
      foregroundColor: const Color(0xff000000),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xff94a3b8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      side: const BorderSide(
        color: Color(0xff94a3b8),
      ),
    ),
  ),
  chipTheme: ChipThemeData.fromDefaults(
    secondaryColor: const Color(0xffe2e8f0),
    labelStyle: const TextStyle(),
    brightness: Brightness.light,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xff94a3b8),
    ),
  ),
  dividerColor: const Color(0xffe2e8f0),
  fontFamily: GoogleFonts.inter().fontFamily,
  textTheme: interTextTheme.copyWith(
    titleLarge: interTextTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: interTextTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    titleSmall: interTextTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
);

class DBox extends SizedBox {
  static const borderRadiusSm = 6.0;
  static const borderRadiusMd = 8.0;
  static const borderRadiusLg = 12.0;
  static const smSpace = 4.0;
  static const mdSpace = 8.0;
  static const lgSpace = 12.0;
  static const xlSpace = 16.0;

  static const fontSm = 12.0;
  static const fontMd = 14.0;
  static const fontLg = 17.0;
  static const fontXl = 24.0;

  const DBox({super.key, super.width, super.height});

  const DBox.horizontalSpaceSm({super.key}) : super(width: smSpace);

  const DBox.horizontalSpaceMd({super.key}) : super(width: mdSpace);

  const DBox.horizontalSpaceLg({super.key}) : super(width: lgSpace);

  const DBox.horizontalSpaceXl({super.key}) : super(width: xlSpace);

  const DBox.horizontalSpace2Xl({super.key}) : super(width: 2 * xlSpace);

  const DBox.horizontalSpace3Xl({super.key}) : super(width: 3 * xlSpace);

  const DBox.verticalSpaceSm({super.key}) : super(height: smSpace);

  const DBox.verticalSpaceMd({super.key}) : super(height: mdSpace);

  const DBox.verticalSpaceLg({super.key}) : super(height: lgSpace);

  const DBox.verticalSpaceXl({super.key}) : super(height: xlSpace);

  const DBox.verticalSpace2Xl({super.key}) : super(height: 2 * xlSpace);

  const DBox.verticalSpace3Xl({super.key}) : super(height: 3 * xlSpace);
}
