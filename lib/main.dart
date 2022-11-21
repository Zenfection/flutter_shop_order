import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:device_preview/device_preview.dart'; //!Debug
// import 'package:flutter/foundation.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';

// Source
import 'package:shop_order/main/store/AppStore.dart';
import 'package:shop_order/screens/GSMainScreen.dart';
import 'package:shop_order/utils/AppConstants.dart';
import 'package:shop_order/main/utils/AppColors.dart';

// Redirect
import 'package:shop_order/screens/GSWalkThroughScreen.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setOrientationPortrait(); // Set Orientation

  await initialize();
  appStore.toggleDarkMode(value: getBoolAsync(DarkModePref));
  appStore.setLoggedIn(getBoolAsync(IsLoggedInSocialLogin));

  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('isLogged')) {
    appStore.setLoggedIn(true);
  }
  if (prefs.containsKey('DarkModePref')) {
    appStore.isDarkModeOn = prefs.getBool('DarkModePref')!;
  }
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(), // Wrap your app
  // )); //! Debug

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
          fontFamily: GoogleFonts.openSans().fontFamily,
          colorScheme: const ColorScheme.light(),
          indicatorColor: appPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: scaffoldSecondaryDark),
          dialogBackgroundColor: Colors.white,
          dialogTheme: const DialogTheme(backgroundColor: Colors.white),
          bottomAppBarColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.white),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: scaffoldColorDark,
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.openSans().fontFamily,
          colorScheme: const ColorScheme.dark(),
          indicatorColor: appPrimaryColor,
          scaffoldBackgroundColor: scaffoldColorDark,
          iconTheme: const IconThemeData(color: Colors.white),
          dialogBackgroundColor: scaffoldColorDark,
          dialogTheme: const DialogTheme(backgroundColor: scaffoldColorDark),
          bottomAppBarColor: scaffoldColorDark,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: scaffoldColorDark),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: scaffoldSecondaryDark),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home:
            appStore.isLoggedIn ? const GSMainScreen() : GSWalkThroughScreen(),
        builder: scrollBehaviour(),
      ),
    );

    //! Debug
    // return MaterialApp(
    //   title: 'Zen Shop Order',
    //   useInheritedMediaQuery: true,
    //   locale: DevicePreview.locale(context),
    //   builder: DevicePreview.appBuilder,
    //   theme: ThemeData.light(),
    //   darkTheme: ThemeData.dark(),
    //   debugShowCheckedModeBanner: false, //? xoá logo Debug

    //   appStore.isLoggedIn ? const GSMainScreen() : GSWalkThroughScreen(),
    // );
  }
}
