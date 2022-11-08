import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/models/ShProduct.dart';
import 'package:shop_hop_prokit/screens/ShOrderSummaryScreen.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShExtension.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

class ShCartFragment extends StatefulWidget {
  static String tag = '/ShProfileFragment';

  @override
  ShCartFragmentState createState() => ShCartFragmentState();
}

class ShCartFragmentState extends State<ShCartFragment> {
  List<ShProduct> list = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadCartProducts();
    setState(() {
      list.clear();
      list.addAll(products);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var cartList = ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: spacing_standard_new),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            color: context.cardColor,
            margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "images/shophop/img/products" + list[index].images![0].src!,
                    width: width * 0.32,
                    height: width * 0.37,
                    fit: BoxFit.fill,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              8.height,
                              Text(list[index].name.toString(), style: boldTextStyle()).paddingOnly(left: 16),
                              4.height,
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                    padding: EdgeInsets.all(spacing_control_half),
                                    child: Icon(Icons.done, color: sh_white, size: 12),
                                  ),
                                  8.width,
                                  Text("M", style: boldTextStyle()),
                                  8.width,
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(spacing_standard, 1, spacing_standard, 1),
                                    decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Qty: 5", style: secondaryTextStyle()).paddingOnly(left: 8),
                                        Icon(Icons.arrow_drop_down, color: sh_textColorPrimary, size: 16),
                                      ],
                                    ),
                                  )
                                ],
                              ).paddingOnly(left: 16.0, top: spacing_control),
                              8.height,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    list[index].on_sale! ? list[index].sale_price.toString().toCurrencyFormat().toString() : list[index].price.toString().toCurrencyFormat().toString(),
                                    style: primaryTextStyle(),
                                  ),
                                  4.width,
                                  Text(
                                    list[index].regular_price.toString().toCurrencyFormat()!,
                                    style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium, decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ).paddingOnly(left: 16.0),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.bookmark_border,
                                    color: appStore.isDarkModeOn ? gray : sh_textColorPrimary,
                                    size: 16,
                                  ),
                                  4.width,
                                  Text(
                                    "Next time buy",
                                    style: secondaryTextStyle(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ).expand()
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            Container(width: 1, color: sh_view_color, height: 35),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    color: appStore.isDarkModeOn ? gray : sh_textColorPrimary,
                                    size: 16,
                                  ),
                                  4.width,
                                  Text(sh_lbl_remove, style: secondaryTextStyle()),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
          // return Chats(mListings[index], index);
        });
    var paymentDetail = Container(
      margin: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard_new, spacing_standard_new, 80),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Text(sh_lbl_payment_details, style: boldTextStyle()),
          ),
          Divider(height: 1, color: sh_view_color),
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Column(
              children: [
                Row(
                  children: [
                    text(sh_lbl_offer),
                    4.width,
                    Text(sh_text_offer_not_available, style: primaryTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    text(sh_lbl_shipping_charge),
                    text(sh_lbl_free, textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    text(sh_lbl_total_amount),
                    text("\$70", textColor: sh_colorPrimary, fontFamily: fontBold, fontSize: textSizeLargeMedium),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

    var bottomButtons = Container(
      height: 65,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: sh_shadow_color, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3)),
      ], color: sh_white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: context.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\$70", style: boldTextStyle()),
                Text(sh_lbl_see_price_detail, style: secondaryTextStyle()),
              ],
            ),
          ).expand(),
          Container(
            child: text(sh_lbl_continue, textColor: sh_white, fontSize: textSizeLargeMedium, fontFamily: fontMedium),
            color: sh_colorPrimary,
            alignment: Alignment.center,
            height: double.infinity,
          ).onTap(
            () {
              ShOrderSummaryScreen().launch(context);
            },
          ).expand()
        ],
      ),
    );
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 70.0),
                child: Column(
                  children: [
                    cartList,
                    paymentDetail,
                  ],
                ),
              ),
            ),
            Container(
              color: context.cardColor,
              padding: EdgeInsets.only(bottom: 60),
              child: bottomButtons,
            )
          ],
        ),
      ),
    );
  }
}
