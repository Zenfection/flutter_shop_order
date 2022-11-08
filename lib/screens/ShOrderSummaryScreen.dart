import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/models/ShAddress.dart';
import 'package:shop_hop_prokit/models/ShProduct.dart';
import 'package:shop_hop_prokit/screens/ShAdressManagerScreen.dart';
// import 'package:shop_hop_prokit/screens/ShPaymentsScreen.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShExtension.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

import '../main.dart';

class ShOrderSummaryScreen extends StatefulWidget {
  static String tag = '/ShOrderSummaryScreen';

  @override
  ShOrderSummaryScreenState createState() => ShOrderSummaryScreenState();
}

class ShOrderSummaryScreenState extends State<ShOrderSummaryScreen> {
  List<ShProduct> list = [];
  List<ShAddressModel> addressList = [];
  var selectedPosition = 0;
  List<String> images = [];
  var currentIndex = 0;
  Timer? timer;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadCartProducts();
    var addresses = await loadAddresses();
    var banner = await loadBanners();
    setState(() {
      list.clear();
      list.addAll(products);
      addressList.clear();
      addressList.addAll(addresses);
      images.clear();
      images.addAll(banner);
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void startTimer() {
    if (timer != null) {
      return;
    }
    timer = new Timer.periodic(new Duration(seconds: 5), (time) {
      setState(() {
        if (currentIndex == images.length - 1) {
          currentIndex = 0;
        } else {
          currentIndex = currentIndex + 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var cartList = isLoaded
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: spacing_standard_new),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                color: context.cardColor,
                margin: EdgeInsets.only(
                    left: spacing_standard_new,
                    right: spacing_standard_new,
                    top: spacing_standard_new),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        "images/shophop/img/products" +
                            list[index].images![0].src!,
                        width: width * 0.25,
                        height: width * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  8.height,
                                  Text(list[index].name.toString(),
                                          style: boldTextStyle())
                                      .paddingOnly(left: 16),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, top: spacing_control),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                          padding: EdgeInsets.all(
                                              spacing_control_half),
                                          child: Icon(Icons.done,
                                              color: sh_white, size: 12),
                                        ),
                                        8.width,
                                        Text("M", style: boldTextStyle()),
                                        8.width,
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              spacing_standard,
                                              1,
                                              spacing_standard,
                                              1),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: sh_view_color,
                                                  width: 1)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Qty: 5",
                                                  style: secondaryTextStyle()),
                                              Icon(Icons.arrow_drop_down,
                                                  color: sh_textColorPrimary,
                                                  size: 16),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        text(
                                            list[index].on_sale!
                                                ? list[index]
                                                    .sale_price
                                                    .toString()
                                                    .toCurrencyFormat()
                                                : list[index]
                                                    .price
                                                    .toString()
                                                    .toCurrencyFormat(),
                                            textColor: sh_colorPrimary,
                                            fontSize: textSizeNormal,
                                            fontFamily: fontMedium),
                                        SizedBox(
                                          width: spacing_control,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 3.0),
                                          child: Text(
                                            list[index]
                                                .regular_price
                                                .toString()
                                                .toCurrencyFormat()!,
                                            style: TextStyle(
                                                color: sh_textColorSecondary,
                                                fontFamily: fontRegular,
                                                fontSize: textSizeSMedium,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              // return Chats(mListings[index], index);
            })
        : Container();
    var paymentDetail = Container(
      margin: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard_new,
          spacing_standard_new, spacing_standard_new),
      decoration:
          BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle,
                spacing_standard_new, spacing_middle),
            child: Text(sh_lbl_payment_details, style: boldTextStyle()),
          ),
          Divider(height: 1, color: sh_view_color),
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle,
                spacing_standard_new, spacing_middle),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    text(sh_lbl_offer),
                    Text(sh_text_offer_not_available,
                        style: primaryTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  children: <Widget>[
                    text(sh_lbl_shipping_charge),
                    text(sh_lbl_free,
                        textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                8.height,
                Row(
                  children: <Widget>[
                    text(sh_lbl_total_amount),
                    text("\$70",
                        textColor: sh_colorPrimary,
                        fontFamily: fontBold,
                        fontSize: textSizeLargeMedium),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    var address = Container(
      width: double.infinity,
      color: context.cardColor,
      padding: EdgeInsets.all(spacing_standard_new),
      margin: EdgeInsets.all(spacing_standard_new),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            addressList[selectedPosition].first_name! +
                " " +
                addressList[selectedPosition].last_name!,
            style: boldTextStyle(size: 18),
          ),
          4.height,
          Text(addressList[selectedPosition].address.toString(),
              style: primaryTextStyle()),
          Text(
              addressList[selectedPosition].city! +
                  "," +
                  addressList[selectedPosition].state!,
              style: secondaryTextStyle()),
          Text(
              addressList[selectedPosition].country! +
                  "," +
                  addressList[selectedPosition].pinCode!,
              style: secondaryTextStyle()),
          16.height,
          Text(addressList[selectedPosition].phone_number.toString(),
              style: secondaryTextStyle()),
          16.height,
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              padding: EdgeInsets.all(spacing_standard),
              child: text(sh_lbl_change_address,
                  fontSize: textSizeMedium,
                  fontFamily: fontMedium,
                  textColor: sh_white),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0),
                  side: BorderSide(color: sh_colorPrimary, width: 1)),
              color: sh_colorPrimary,
              onPressed: () async {
                var pos = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShAddressManagerScreen())) ??
                    selectedPosition;
                setState(() {
                  selectedPosition = pos;
                });
              },
            ),
          )
        ],
      ),
    );
    var bottomButtons = Container(
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: sh_shadow_color,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3))
      ], color: sh_white),
      child: Row(
        children: <Widget>[
          Container(
            color: context.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("\$70", style: boldTextStyle()),
                4.height,
                Text(sh_lbl_see_price_detail, style: secondaryTextStyle()),
              ],
            ),
          ).expand(),
          Container(
            child: text(sh_lbl_continue,
                textColor: sh_white,
                fontSize: textSizeLargeMedium,
                fontFamily: fontMedium),
            color: sh_colorPrimary,
            alignment: Alignment.center,
            height: double.infinity,
          ).onTap(() {
            // ShPaymentsScreen().launch(context);
          }).expand()
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_order_summary, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 70.0),
              child: Column(
                children: <Widget>[
                  isLoaded ? address : Container(),
                  cartList,
                  paymentDetail,
                  images.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: sh_view_color, width: 0.5)),
                          margin: EdgeInsets.all(spacing_standard_new),
                          child: Image.asset(
                            images[currentIndex],
                            width: double.infinity,
                            height: width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Container(color: sh_white, child: bottomButtons)
        ],
      ),
    );
  }
}
