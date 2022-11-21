// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_order/model/GSModel.dart';
// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/utils/GSDataProvider.dart';

// Redirect

class GSSuccessfulOrderScreen extends StatefulWidget {
  static String tag = '/GSSuccessfulOrderScreen';

  const GSSuccessfulOrderScreen({super.key});

  @override
  GSSuccessfulOrderScreenState createState() => GSSuccessfulOrderScreenState();
}

class GSSuccessfulOrderScreenState extends State<GSSuccessfulOrderScreen> {
  String fullname = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(primaryColor);
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    var data = await getUserInfo(username, password);
    setState(() {
      fullname = data[0].fullname;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(primaryColor);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(successFullImage,
                  height: 200, width: 200, fit: BoxFit.cover),
              30.height,
              Text(
                "Đặt đơn hàng thành công",
                style: boldTextStyle(color: Colors.white, size: 20),
                textAlign: TextAlign.center,
              ),
              20.height,
              // createRichText(list: [
              //   TextSpan(
              //       text: "Kiểm tra tại mục:",
              //       style: primaryTextStyle(color: Colors.white, size: 18)),
              //   TextSpan(
              //       text: " Đơn Hàng\n",
              //       style: boldTextStyle(color: Colors.white)),
              //   TextSpan(
              //       text: "about next steps information.",
              //       style: primaryTextStyle(color: Colors.white, size: 18)),
              // ]),
            ],
          ).paddingAll(16).paddingBottom(context.height() * 0.2),
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 30),
            width: context.width(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topLeft: 16, topRight: 16),
              backgroundColor:
                  appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cám ơn: $fullname đã đặt hàng", style: boldTextStyle()),
                16.height,
                Text("Hãy theo dõi đơn hàng của bạn bên dưới",
                    style: secondaryTextStyle()),
                40.height,
                gsAppButton(context, "Theo dõi đơn hàng", () {
                  finish(context);
                  GSMyOrderModel();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
