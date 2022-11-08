import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/screens/ShAdressManagerScreen.dart';
import 'package:shop_hop_prokit/screens/ShOffersScreen.dart';
import 'package:shop_hop_prokit/screens/ShQuickPayCardsScreen.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShImages.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';
import 'ShOrderListScreen.dart';

class ShAccountScreen extends StatefulWidget {
  static String tag = '/ShAccountScreen';

  @override
  ShAccountScreenState createState() => ShAccountScreenState();
}

class ShAccountScreenState extends State<ShAccountScreen> {
  var firstNameCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      firstNameCont.text = "+919656231245";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_account, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            30.height,
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: spacing_standard,
              margin: EdgeInsets.all(spacing_control),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              child:
                  CircleAvatar(backgroundImage: AssetImage(ic_user), radius: 60)
                      .paddingAll(4),
            ),
            Text("Lê Tuấn Kiệt", style: boldTextStyle(size: 24)),
            //* Zen delete verify phone number
            Padding(
              padding: EdgeInsets.only(
                  left: spacing_standard_new,
                  bottom: spacing_standard_new,
                  right: spacing_standard_new),
              child: Column(
                children: <Widget>[
                  // getRowItem(sh_lbl_address_manager, callback: () {
                  //   ShAddressManagerScreen().launch(context);
                  // }),
                  SizedBox(height: spacing_standard_new),
                  getRowItem(sh_lbl_my_order, callback: () {
                    ShOrderListScreen().launch(context);
                  }),
                  // SizedBox(height: spacing_standard_new),
                  // getRowItem(sh_lbl_my_offers, callback: () {
                  //   ShOffersScreen().launch(context);
                  // }),
                  SizedBox(height: spacing_standard_new),
                  getRowItem(sh_lbl_wish_list, callback: () {
                    finish(context);
                  }),
                  // SizedBox(height: spacing_standard_new),
                  // getRowItem(sh_lbl_quick_pay_cards, callback: () {
                  //   ShQuickPayCardsScreen().launch(context);
                  // }),
                  SizedBox(height: spacing_standard_new),
                  getRowItem(sh_lbl_help_center),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    // height: double.infinity,
                    child: MaterialButton(
                      padding: EdgeInsets.all(spacing_standard),
                      child: text("Đăng Xuất",
                          fontSize: textSizeNormal,
                          fontFamily: fontMedium,
                          textColor: sh_colorPrimary),
                      textColor: sh_white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0),
                          side: BorderSide(color: sh_colorPrimary, width: 1)),
                      color: context.cardColor,
                      onPressed: () => {finish(context)},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRowItem(String title, {VoidCallback? callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
        padding:
            EdgeInsets.fromLTRB(spacing_standard, 0, spacing_control_half, 0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(title, style: primaryTextStyle())),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right,
                  color: appStore.isDarkModeOn ? white : sh_textColorPrimary,
                  size: 24),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
