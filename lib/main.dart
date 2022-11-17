import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Source
import 'package:shop_order/main/store/AppStore.dart';
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
          fontFamily: GoogleFonts.poppins().fontFamily,
          accentColor: appPrimaryColor,
          indicatorColor: appPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: scaffoldSecondaryDark),
          dialogBackgroundColor: Colors.white,
          dialogTheme: const DialogTheme(backgroundColor: Colors.white),
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
          primaryColor: Colors.white,
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.poppins().fontFamily,
          accentColor: appPrimaryColor,
          indicatorColor: appPrimaryColor,
          scaffoldBackgroundColor: scaffoldColorDark,
          iconTheme: const IconThemeData(color: Colors.white),
          dialogBackgroundColor: scaffoldColorDark,
          dialogTheme: const DialogTheme(backgroundColor: scaffoldColorDark),
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
        home: GSWalkThroughScreen(),
        builder: scrollBehaviour(),
      ),
    );

    // return MaterialApp(
    //   title: 'Zen Shop Order',
    //   useInheritedMediaQuery: true,
    //   locale: DevicePreview.locale(context),
    //   builder: DevicePreview.appBuilder,
    //   theme: ThemeData.light(),
    //   darkTheme: ThemeData.dark(),
    //   debugShowCheckedModeBanner: false, //? xoá logo Debug

    //   home: GSWalkThroughScreen(),
    // );
  }
}
