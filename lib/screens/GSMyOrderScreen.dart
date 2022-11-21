import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_order/component/GSOrderPendingComponent.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:shop_order/component/GSCancelOrderComponent.dart';
import 'package:shop_order/component/GSOrderShippingComponent.dart';
import 'package:shop_order/component/GSOrderDeliveredComponent.dart';

class GSMyOrderScreen extends StatefulWidget {
  static String tag = '/GSMyOrderScreen';

  const GSMyOrderScreen({super.key});

  @override
  GSMyOrderScreenState createState() => GSMyOrderScreenState();
}

class GSMyOrderScreenState extends State<GSMyOrderScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  reload() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('order_pending');
    prefs.remove('order_shipping');
    prefs.remove('order_delivered');
    prefs.remove('order_cancel');
    //reload page
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appStore.isDarkModeOn ? scaffoldColorDark : gs_background,
      appBar: AppBar(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Đơn Hàng', style: boldTextStyle(size: 20)),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.arrowsRotate,
                color: appStore.isDarkModeOn ? Colors.white : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  reload();
                });
                // const GSNotificationScreen().launch(context);
              },
            ),
          ],
        ),
        // title: Text("Đơn Hàng", style: boldTextStyle(size: 20)),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: Material(
                color: appStore.isDarkModeOn
                    ? scaffoldSecondaryDark
                    : Colors.white,
                child: const TabBar(
                  indicatorColor: primaryColor,
                  unselectedLabelColor: Colors.grey,
                  labelColor: primaryColor,
                  tabs: [
                    Tab(text: "Pending"),
                    Tab(text: "Shipping"),
                    Tab(text: "Delivered"),
                    Tab(text: "Cancelled"),
                  ],
                ),
              ),
            ),
            const TabBarView(
              children: [
                GSOrderPendingComponent(),
                GSOrderShippingComponent(),
                GSOrderDeliveredComponent(),
                GSOrderCanceledComponent(),
              ],
            ).expand()
          ],
        ),
      ),
    );
  }
}
