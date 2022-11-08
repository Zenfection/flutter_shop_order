import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/models/ShOrder.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShExtension.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

// ignore: must_be_immutable
class ShOrderDetailScreen extends StatefulWidget {
  static String tag = '/ShOrderDetailScreen';
  ShOrder? order;

  ShOrderDetailScreen({this.order});

  @override
  ShOrderDetailScreenState createState() => ShOrderDetailScreenState();
}

class ShOrderDetailScreenState extends State<ShOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var item = Container(
      color: context.cardColor,
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              "images/shophop/img/products" + widget.order!.item!.image!,
              width: width * 0.3,
              height: width * 0.35,
              fit: BoxFit.fill,
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
                        Text(widget.order!.item!.name.toString(), style: boldTextStyle()).paddingOnly(left: 16.0),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                              padding: EdgeInsets.all(spacing_control_half),
                              child: Icon(Icons.done, color: sh_white, size: 16),
                            ),
                            16.width,
                            Text("M", style: boldTextStyle()),
                          ],
                        ).paddingOnly(left: 16.0, top: spacing_control),
                        text("Total item- 1").paddingOnly(left: 16.0, top: 4.0, bottom: 4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            text(widget.order!.item!.price.toString().toCurrencyFormat(), textColor: sh_colorPrimary, fontSize: textSizeNormal, fontFamily: fontMedium),
                            4.width,
                            Text(
                              "0".toString().toCurrencyFormat()!,
                              style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium, decoration: TextDecoration.lineThrough),
                            ).paddingOnly(bottom: 4.0),
                          ],
                        ).paddingOnly(left: 16.0),
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
    var orderStatus = Container(
      height: width * 0.32,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                ),
                VerticalDivider(color: Colors.grey).expand(),
                Container(
                  margin: EdgeInsets.only(bottom: 4.0),
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                ),
              ],
            ),
            16.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(widget.order!.order_date! + "\n Order Placed", maxLines: 2, style: primaryTextStyle()),
                  Text("Order Pending", style: primaryTextStyle()),
                ],
              ),
            )
          ],
        ),
      ),
    );
    var paymentDetail = Container(
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sh_lbl_payment_details, style: boldTextStyle()).paddingSymmetric(horizontal: 16, vertical: 8),
          Divider(height: 1, color: sh_view_color),
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    text(sh_lbl_offer),
                    Text(sh_text_offer_not_available, style: primaryTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  children: <Widget>[
                    text(sh_lbl_shipping_charge),
                    text(sh_lbl_free, textColor: Colors.green, fontFamily: fontMedium),
                  ],
                ),
                8.height,
                Row(
                  children: <Widget>[
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
    var shippingDetail = Container(
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
      decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Text(sh_lbl_shipping_details, style: boldTextStyle()),
          ),
          Divider(height: 1, color: sh_view_color),
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_middle, spacing_standard_new, spacing_middle),
            child: Column(
              children: [
                Row(
                  children: [
                    text(sh_lbl_order_id),
                    Text(widget.order!.order_number.toString(), style: primaryTextStyle()),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    text(sh_lbl_order_date),
                    Text(widget.order!.order_date.toString(), style: primaryTextStyle()),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_my_orders, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            item,
            orderStatus,
            shippingDetail,
            paymentDetail,
            40.height,
          ],
        ),
      ),
    );
  }
}
