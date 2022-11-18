// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Source
import '../../../main.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/AppConstants.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/utils/AppWidget.dart';

// Redicrect

// ignore: must_be_immutable
class GSRecommendationDetailsScreen extends StatefulWidget {
  static String tag = '/GSRecommendationDetailsScreen';
  GSRecommendedModel? recommendedDetails;

  GSRecommendationDetailsScreen({super.key, this.recommendedDetails});

  @override
  GSRecommendationDetailsScreenState createState() =>
      GSRecommendationDetailsScreenState();
}

class GSRecommendationDetailsScreenState
    extends State<GSRecommendationDetailsScreen> {
  int ratingNum = 0;
  int counter = 1;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    caculator();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  caculator() async {
    totalAmount =
        counter * widget.recommendedDetails!.salePrice.validate().toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appStore.isDarkModeOn ? scaffoldColorDark : gs_background,
      appBar: appBarWidget('',
          color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(widget.recommendedDetails!.image!,
                              fit: BoxFit.cover, height: 200, width: 200)
                          .center(),
                      16.height,
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.recommendedDetails!.title.validate(),
                                  style: boldTextStyle(size: 20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.recommendedDetails!.price
                                        .validate()
                                        .round()
                                        .toVND(),
                                    style: secondaryTextStyle(
                                        color: grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  8.width,
                                  Text(
                                      widget.recommendedDetails!.salePrice
                                          .validate()
                                          .round()
                                          .toVND(),
                                      style: boldTextStyle(
                                          size: 18, color: redColor))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      8.height,
                      const Divider(),
                      8.height,
                      Text(widget.recommendedDetails!.description.validate(),
                          style: primaryTextStyle(size: 14)),
                      20.height,
                      Text("Review", style: boldTextStyle()),
                      16.height,
                      Row(
                        children: [
                          RatingBar.builder(
                              initialRating: widget.recommendedDetails!.ranking
                                      .validate()
                                      .toDouble() /
                                  2,
                              minRating: 1,
                              itemCount: 5,
                              glow: false,
                              allowHalfRating: true,
                              maxRating: 5,
                              itemSize: 20,
                              ignoreGestures: true,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                ratingNum = rating.toInt();
                                setState(() {});
                              }),
                          8.width,
                          Text("(Tính năng đăng phát triển)",
                                  style: secondaryTextStyle(size: 12))
                              .expand(),
                          Image.asset(nextImage,
                              width: 20,
                              height: 20,
                              color: const Color.fromARGB(255, 219, 210, 210)),
                        ],
                      ).onTap(() {}),
                    ],
                  ).paddingAll(16))
              .expand(),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            width: context.width(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 12, topLeft: 12),
              boxShadow: defaultBoxShadow(),
              backgroundColor:
                  appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Tỗng Tiền: ",
                        style: boldTextStyle(
                            size: 20,
                            color: const Color.fromARGB(255, 229, 158, 5))),
                    8.width,
                    Text(totalAmount.round().toVND(),
                            style: boldTextStyle(
                                size: 20,
                                color: const Color.fromARGB(255, 101, 97, 86)))
                        .expand(),
                    Row(
                      children: [
                        counter != 1
                            ? commonCacheImageWidget(minusImage, 20, width: 20)
                                .onTap(() {
                                setState(() {
                                  counter--;
                                  caculator();
                                });
                              })
                            : Container(),
                        16.width,
                        Text('$counter', style: boldTextStyle()),
                        16.width,
                        commonCacheImageWidget(addImage, 24, width: 24)
                            .onTap(() {
                          setState(() {
                            counter++;
                            caculator();
                          });
                        }),
                      ],
                    ),
                  ],
                ),
                20.height,
                // Text(
                //   widget.recommendedDetails!.description.validate(),
                //   style: secondaryTextStyle(),
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 2,
                // ),
                30.height,
                gsAppButton(context, "Thêm Vào Giỏ Hàng", () {
                  addProductCart(
                      widget.recommendedDetails!.id.validate(), counter);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

addProductCart(int id, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  String password = prefs.getString('password') ?? '';
  var uri = Uri.parse('$baseUrl/add_product_cart');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
    'id': id.toString(),
    'qty': qty.toString(),
  });
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (data['status'] == 'soldout') {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
