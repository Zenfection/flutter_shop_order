import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/models/ShOrder.dart';
import 'package:shop_hop_prokit/screens/ShOrderDetailScreen.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShExtension.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';


class ShOrderListScreen extends StatefulWidget {
  static String tag = '/ShOrderListScreen';

  @override
  ShOrderListScreenState createState() => ShOrderListScreenState();
}

class ShOrderListScreenState extends State<ShOrderListScreen> {
  List<ShOrder> list = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var orders = await loadOrders();
    setState(() {
      list.clear();
      list.addAll(orders);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var listView = ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10.0),
          color: context.cardColor,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 1)),
                  child: Image.asset(
                    "images/shophop/img/products" + list[index].item!.image!,
                    fit: BoxFit.cover,
                    height: width * 0.35,
                    width: width * 0.29,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(list[index].item!.name!, style: boldTextStyle()),
                      4.height,
                      text(
                        list[index].item!.price.toString().toCurrencyFormat(),
                        textColor: sh_colorPrimary,
                        fontFamily: fontMedium,
                        fontSize: textSizeNormal,
                      ),
                      8.height,
                      Expanded(
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: spacing_standard,
                                    height: spacing_standard,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                                  ),
                                  VerticalDivider(color: Colors.grey).expand(),
                                  Container(
                                    width: spacing_standard,
                                    height: spacing_standard,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      list[index].order_date! + "\n Order Placed",
                                      maxLines: 2,
                                      style: primaryTextStyle(size: 14),
                                    ),
                                    Text("Order Pending", style: secondaryTextStyle()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ).onTap(() {
          ShOrderDetailScreen(order: list[index]).launch(context);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_my_orders, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
      ),
      body: Container(width: width, child: listView),
    );
  }
}
