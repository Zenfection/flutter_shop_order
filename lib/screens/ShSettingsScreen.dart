import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';

class ShSettingsScreen extends StatefulWidget {
  static String tag = '/ShSettingsScreen';

  @override
  ShSettingsScreenState createState() => ShSettingsScreenState();
}

class ShSettingsScreenState extends State<ShSettingsScreen> {
  bool pushNotification = false;
  bool smsNotification = false;
  bool emailNotification = false;
  String? selectedValue = "English(US)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_settings, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actionsIconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_colorPrimary),
        actions: [
          cartIcon(context, 3),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //* Zen Mod
            Container(
              margin: EdgeInsets.only(
                  left: spacing_standard_new, right: spacing_standard_new),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Dark Mode', style: primaryTextStyle()),
                      Switch(
                        value: appStore.isDarkModeOn,
                        activeColor: sh_colorPrimary,
                        onChanged: (s) {
                          setState(() {});
                          appStore.toggleDarkMode(value: s);
                        },
                      )
                    ],
                  ),
                  Text('Nến tối', style: secondaryTextStyle()),
                  SizedBox(height: spacing_standard_new),
                  divider()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(spacing_standard_new),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(sh_lbl_language, style: primaryTextStyle()),
                      DropdownButton<String>(
                        underline: SizedBox(),
                        items: <String>["English(US)", "English(Canada)"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: primaryTextStyle()),
                          );
                        }).toList(),
                        //hint:Text(selectedValue),
                        value: selectedValue,
                        onChanged: (newVal) {
                          setState(() {
                            selectedValue = newVal;
                          });
                        },
                      ),
                    ],
                  ),
                  16.height,
                  divider()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
