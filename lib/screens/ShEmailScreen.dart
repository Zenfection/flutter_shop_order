import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';

class ShEmailScreen extends StatefulWidget {
  static String tag = '/ShEmailScreen';

  @override
  ShEmailScreenState createState() => ShEmailScreenState();
}

class ShEmailScreenState extends State<ShEmailScreen> {
  var emailCont = TextEditingController();
  var descriptionCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      emailCont.text = sh_reference_email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_email, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actionsIconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_colorPrimary),
        actions: <Widget>[
          cartIcon(context, 3),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: emailCont,
              enabled: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              style: primaryTextStyle(),
              autofocus: false,
              decoration: formFieldDecoration(sh_lbl_email_to_woobox),
            ),
            16.height,
            TextFormField(
              controller: descriptionCont,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              style: primaryTextStyle(),
              autofocus: false,
              decoration: formFieldDecoration(sh_lbl_description),
            ),
            50.height,
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0)),
              onPressed: () {},
              color: sh_colorPrimary,
              child: text(sh_lbl_send_mail,
                  fontFamily: fontMedium,
                  fontSize: textSizeLargeMedium,
                  textColor: sh_white),
            )
          ],
        ),
      ),
    );
  }
}
