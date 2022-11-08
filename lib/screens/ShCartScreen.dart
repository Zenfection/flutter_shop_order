import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/screens/ShCartFragment.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';

class ShCartScreen extends StatefulWidget {
  static String tag = '/ShCartScreen';

  @override
  ShCartScreenState createState() => ShCartScreenState();
}

class ShCartScreenState extends State<ShCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_account, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: ShCartFragment(),
    );
  }
}
