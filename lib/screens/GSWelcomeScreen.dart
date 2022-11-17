// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/widget/welcome.dart';

// Redicrect
import 'GSRegisterScreen.dart';
import 'GSLoginScreen.dart';

class GSWelcomeScreen extends StatefulWidget {
  static String tag = '/GSWelcomeScreen';

  const GSWelcomeScreen({super.key});

  @override
  GSWelcomeScreenState createState() => GSWelcomeScreenState();
}

class GSWelcomeScreenState extends State<GSWelcomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkModeOn ? Colors.transparent : Colors.white,
        statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        // image
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : gs_background,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(welcomeImage,
                      height: 300, width: 350, fit: BoxFit.cover),
                ),
                8.height,
              ],
            ).paddingBottom(context.height() * 0.3),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(40),
                width: context.width(),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topLeft: 16, topRight: 16),
                  backgroundColor: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : const Color(0xFFf7f7f7),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chào mừng bạn đến với \n Zen Shop Order",
                        style: boldTextStyle(size: 25),
                        textAlign: TextAlign.center),
                    16.height,
                    Text("Hãy đăng nhập để trãi nghiệm ứng dụng của tôi",
                        style: secondaryTextStyle(size: 14)),
                    16.height,
                    gsAppButton(context, "Đăng Nhập", () {
                      finish(context);
                      const GSLoginScreen().launch(context);
                    }),
                    16.height,
                    // AppButton(
                    //   width: context.width(),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //       commonCacheImageWidget(gs_apple_icon, 24, width: 24),
                    //       8.width,
                    //       Text("Sign in with Apple",
                    //           style: boldTextStyle(color: Colors.white)),
                    //     ],
                    //   ),
                    //   color: Colors.black,
                    //   shapeBorder: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(0))),
                    //   onTap: () {},
                    // ),
                    // 16.height,
                    // AppButton(
                    //   color: appStore.isDarkModeOn
                    //       ? scaffoldSecondaryDark
                    //       : Colors.white,
                    //   elevation: 0,
                    //   width: context.width(),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Image.asset(gs_google_icon, height: 24, width: 24),
                    //       8.width,
                    //       Text("Sign in with Google", style: boldTextStyle()),
                    //     ],
                    //   ),
                    //   shapeBorder: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(0)),
                    //     side: BorderSide(color: Colors.grey[300]!),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // 16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nếu bạn chưa có tài khoản,hãy",
                            style: secondaryTextStyle(size: 15)),
                        3.width,
                        Text("Đăng Ký",
                            style: secondaryTextStyle(
                                color: primaryColor, size: 17)),
                      ],
                    ).onTap(() {
                      const GSRegisterScreen().launch(context);
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
