// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Source
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/widget/order.dart';

class GSOrderPendingComponent extends StatefulWidget {
  static String tag = '/GSOrderPendingComponent';

  const GSOrderPendingComponent({super.key});

  @override
  GSOrderPendingComponentState createState() => GSOrderPendingComponentState();
}

class GSOrderPendingComponentState extends State<GSOrderPendingComponent> {
  int ratingNum = 0;
  List<GSMyOrderModel> pendingOrderList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    if (prefs.containsKey('order_pending')) {
      try {
        String orderPending = prefs.getString('order_pending')!;
        List data = jsonDecode(orderPending);
        pendingOrderList
            .addAll(data.map((e) => GSMyOrderModel.fromJson(e)).toList());
      } catch (e) {
        pendingOrderList = await getOrderStatus(username, password, 'pending');
      }
    } else {
      pendingOrderList = await getOrderStatus(username, password, 'pending');
    }

    setState(() {
      pendingOrderList = pendingOrderList;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          myOrderWidget(
            ratingBar: RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              itemCount: 5,
              glow: false,
              maxRating: 5,
              itemSize: 30,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ratingNum = rating.toInt();
                setState(() {});
              },
            ),
            orderList: pendingOrderList,
            onTap: () {},
          ),
          cartNotFound()
              .visible(pendingOrderList.isEmpty)
              .paddingTop(context.height() * 0.3)
        ],
      ),
    );
  }
}
