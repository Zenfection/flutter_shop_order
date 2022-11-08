import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/models/ShPaymentCard.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShImages.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

import 'ShAddCardScreen.dart';

class ShQuickPayCardsScreen extends StatefulWidget {
  static String tag = '/ShQuickPayCardsScreen';

  @override
  ShQuickPayCardsScreenState createState() => ShQuickPayCardsScreenState();
}

class ShQuickPayCardsScreenState extends State<ShQuickPayCardsScreen> {
  List<ShPaymentCard> list = [];
  int? selectedCard = 0;

  editCard(ShPaymentCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ShAddCardScreen(
                  paymentCard: card,
                )));
  }

  deleteCard(ShPaymentCard card) {
    setState(() {
      list.remove(card);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      list.add(ShPaymentCard());
      list.add(ShPaymentCard());
      list.add(ShPaymentCard());
      list.add(ShPaymentCard());
      list.add(ShPaymentCard());
      list.add(ShPaymentCard());
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final listView = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
      itemBuilder: (item, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: spacing_standard_new),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.green,
                icon: Icons.edit,
                onTap: () => editCard(list[index]),
              )
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.redAccent,
                icon: Icons.delete_outline,
                onTap: () => deleteCard(list[index]),
              ),
            ],
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedCard = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: spacing_standard_new,
                  left: spacing_standard_new,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 210,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            card,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 210,
                          ),
                          Padding(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      text("Debit card", textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontBold),
                                      text("MVK Bank", textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontBold)
                                    ],
                                  ),
                                  SizedBox(
                                    height: spacing_middle,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(chip, width: 50, height: 30, fit: BoxFit.fill),
                                        16.height,
                                        text(
                                          "3434 3434 3434",
                                          textColor: sh_white,
                                          fontFamily: fontMedium,
                                          fontSize: textSizeLargeMedium,
                                        ),
                                        text("valid 12/12", textColor: sh_white, fontSize: textSizeSMedium),
                                        8.height,
                                        text("JOHN", textColor: sh_white, fontFamily: fontMedium, fontSize: textSizeMedium),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(14)),
                        ],
                      ),
                    ),
                    Radio(
                        value: index,
                        groupValue: selectedCard,
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedCard = value;
                          });
                        },
                        activeColor: sh_white)
                  ],
                ),
              ),
            ),
          ),
        );
      },
      shrinkWrap: true,
      itemCount: list.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(sh_title_payment, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(sh_lbl_quick_pay, style: boldTextStyle()),
                  MaterialButton(
                    textColor: sh_colorPrimary,
                    padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: 0, bottom: 0),
                    child: text(sh_lbl_add_card, fontSize: textSizeSMedium, textColor: sh_colorPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(spacing_large),
                      side: BorderSide(color: sh_colorPrimary),
                    ),
                    onPressed: () {
                      ShAddCardScreen().launch(context);
                    },
                  )
                ],
              ),
            ),
            listView
          ],
        ),
      ),
    );
  }
}
