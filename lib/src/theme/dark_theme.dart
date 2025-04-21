import 'package:campuscravings/src/src.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.blueGrey, // Custom background color
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
    ), // Text style
    actionTextColor: Colors.orange, // Color of action buttons like "Dismiss"
    behavior: SnackBarBehavior.floating, // Floating SnackBar behavior
    width: 400,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: AppColors.accent, width: 2),
    ),
  ),
  dataTableTheme: DataTableThemeData(
    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    textStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    color: Colors.grey.shade800,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.black,
    dayOverlayColor: WidgetStateProperty.all(Colors.red),
    todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.purple;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.black;
    }),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: AppColors.accent,
    secondary: Colors.amber,
    onPrimary: AppColors.accent,
    outline: Colors.green,
    onPrimaryContainer: Colors.pink,
    primaryContainer: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.grey.shade900,
    shape: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
  scaffoldBackgroundColor: Colors.black,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    linearTrackColor: Colors.grey.shade800,
    color: Colors.purple,
  ),
  primaryColor: AppColors.accent,
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.grey),
    bodyMedium: TextStyle(color: Colors.grey),
    bodySmall: TextStyle(color: Colors.white),
  ),
);
