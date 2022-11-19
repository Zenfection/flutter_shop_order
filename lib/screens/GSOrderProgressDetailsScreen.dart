// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// Source
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/utils/GSDataProvider.dart';

// Redirect
import 'GSRecommendationDetailsScreen.dart';

// ignore: must_be_immutable
class GSOrderProgressDetailsScreen extends StatefulWidget {
  static String tag = '/GSOrderProgressDetailsScreen';
  GSMyOrderModel? orderProgressList;

  GSOrderProgressDetailsScreen({super.key, this.orderProgressList});

  @override
  GSOrderProgressDetailsScreenState createState() =>
      GSOrderProgressDetailsScreenState();
}

class GSOrderProgressDetailsScreenState
    extends State<GSOrderProgressDetailsScreen> {
  List<GSRecommendedModel> orderProductList = [];
  int totalMoney = 0;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    String idOrder = widget.orderProgressList!.orderId.toString();
    if (prefs.containsKey('product_order_$idOrder')) {
      String productOrder = prefs.getString('product_order_$idOrder')!;
      try {
        List data = jsonDecode(productOrder);
        orderProductList
            .addAll(data.map((e) => GSRecommendedModel.fromJson(e)).toList());
      } catch (e) {
        orderProductList = await getOrderProduct(username, password, idOrder);
      }
    } else {
      orderProductList = await getOrderProduct(username, password, idOrder);
    }
    setState(() {
      orderProductList = orderProductList;
    });
    calculate();
  }

  calculate() async {
    totalMoney = 0;
    for (var element in orderProductList) {
      setState(() {
        totalMoney +=
            ((element.salePrice.validate()) * (element.qty.validate())).toInt();
      });
    }
  }

  // Widget orderStatusWidget(OrderStatusWidget orderStatusWidget) {
  //   return TimelineTile(
  //     alignment: TimelineAlign.manual,
  //     lineXY: 0.1,
  //     isFirst: true,
  //     indicatorStyle: const IndicatorStyle(
  //       width: 20,
  //       color: primaryColor,
  //       padding: EdgeInsets.all(8),
  //     ),
  //     endChild: orderStatusWidget,
  //     beforeLineStyle: const LineStyle(
  //       color: primaryColor,
  //     ),
  //   );
  // }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        elevation: 1,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: primaryColor),
              onPressed: () {
                finish(context);
              },
            ),
            8.width,
            Text('Đơn Hàng ${widget.orderProgressList!.orderId.validate()}',
                style: boldTextStyle()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Đặt vào ngày ${widget.orderProgressList!.date!}',
                    style: primaryTextStyle())
                .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
            const Divider(),
            Text("Chi Tiết Đơn Hàng", style: boldTextStyle())
                .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
            Column(
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ListView.separated(
                    separatorBuilder: (_, i) => const Divider(),
                    shrinkWrap: true,
                    reverse: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: orderProductList.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) {
                      GSRecommendedModel mData = orderProductList[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  GSRecommendationDetailsScreen(
                                          recommendedDetails: mData)
                                      .launch(context);
                                },
                                child: Ink.image(
                                  image: AssetImage(mData.image.validate()),
                                  // fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              30.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${mData.title.validate()} x ${mData.qty}',
                                      style: boldTextStyle(size: 17),
                                      maxLines: 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        mData.price.validate().round().toVND(),
                                        style: secondaryTextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            size: 14),
                                      ),
                                      8.width,
                                      Text(
                                          mData.salePrice
                                              .validate()
                                              .round()
                                              .toVND(),
                                          style: boldTextStyle(
                                              color: redColor, size: 16)),
                                    ],
                                  ),
                                  10.height,
                                ],
                              ),
                            ],
                          )
                        ],
                      ).onTap(() {});
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            8.height,
            Text("Địa Chỉ Giao Hàng", style: boldTextStyle())
                .paddingOnly(left: 18, right: 16),
            8.height,
            Text(widget.orderProgressList!.address.validate(),
                    style: primaryTextStyle(size: 16))
                .paddingOnly(left: 16, right: 16),
            8.height,
            const Divider(),
            8.height,
            // Text("Courier", style: boldTextStyle())
            //     .paddingOnly(left: 16, right: 16),
            // 8.height,
            // Row(
            //   children: [
            //     Image.asset(appLogo, height: 340, width: 40, fit: BoxFit.cover),
            //     8.width,
            //     Text("Grocery Courier", style: primaryTextStyle(size: 14)),
            //   ],
            // ).paddingOnly(left: 16, right: 16),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng tiền: ", style: boldTextStyle(size: 20))
                    .paddingOnly(left: 16, right: 16),
                Text(totalMoney.round().toVND(),
                        style: boldTextStyle(size: 20, color: primaryColor))
                    .paddingOnly(left: 16, right: 16),
              ],
            ),
            8.height,
            const Text("Cám ơn bạn đã sử dụng dịch vụ của chúng tôi.")
                .paddingOnly(left: 16, right: 16, bottom: 16),
          ],
        ),
      ),
    );
  }
}
