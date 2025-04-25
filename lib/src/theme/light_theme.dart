import 'package:campuscravings/src/src.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.lightText,
    ),
    contentPadding: const EdgeInsets.all(15),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.textFieldBorder,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.textFieldBorder,
        width: 1.5,
      ),
    ),
    prefixIconConstraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
  ),

  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
  ).copyWith(surface: AppColors.background),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.white),
    trackColor: WidgetStateProperty.all(Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.bold)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    textStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    color: Colors.grey.shade100,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.blueGrey,
    surfaceTintColor: Colors.blueGrey,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
      side: BorderSide.none,
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    rangeSelectionBackgroundColor: AppColors.accent,
    todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.deepOrange;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.black;
    }),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: 1.5,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
    ),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  scaffoldBackgroundColor: Colors.white,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    linearTrackColor: Colors.grey.shade200,
    color: AppColors.accent,
  ),
  primaryColor: AppColors.accent,
  chipTheme: ChipThemeData(
    deleteIconBoxConstraints: BoxConstraints(minWidth: 9, minHeight: 9),
    shape: StadiumBorder(side: BorderSide(color: AppColors.dividerColor)),
    backgroundColor: AppColors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: Dimensions.fontSizeMoreOverLarge,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: Dimensions.fontSizeExtraLarge,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: Dimensions.fontSizeDefault,
      fontWeight: FontWeight.w400,
      color: AppColors.lightText,
    ),
    bodySmall: TextStyle(
      fontSize: Dimensions.fontSizeSmall,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
    ),
  ).apply(fontFamily: 'SofiaPro'),
);
