import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/models/ShProduct.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShExtension.dart';
import 'package:shop_order/utils/ShStrings.dart';

class ShWishlistFragment extends StatefulWidget {
  static String tag = '/ShProfileFragment';

  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<ShWishlistFragment> {
  List<ShProduct> list = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();
    setState(() {
      list.clear();
      list.addAll(products);
    });
  }

  Future<List<ShProduct>> loadProducts() async {
    String jsonString =
        await loadContentAsset('assets/shophop_data/wishlist_products.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => ShProduct.fromJson(i)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 70),
        itemBuilder: (context, index) {
          return Container(
            color: appStore.isDarkModeOn ? scaffoldDarkColor : white,
            margin: EdgeInsets.only(
                left: spacing_standard_new,
                right: spacing_standard_new,
                top: spacing_standard_new),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    "images/shophop/img/products" + list[index].images![0].src!,
                    width: width * 0.25,
                    height: width * 0.3,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      8.height,
                      Text(list[index].name!, style: boldTextStyle())
                          .paddingOnly(left: 16.0),
                      Text(
                              list[index]
                                  .regular_price
                                  .toString()
                                  .toCurrencyFormat()
                                  .toString(),
                              style: boldTextStyle(color: sh_colorPrimary))
                          .paddingOnly(left: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.add_shopping_cart,
                                  color: sh_textColorPrimary, size: 16),
                              Text(sh_lbl_move_to_cart,
                                  style: primaryTextStyle()),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ).expand(),
                          Row(
                            children: [
                              Icon(Icons.delete_outline,
                                  color: sh_textColorPrimary, size: 16),
                              Text(sh_lbl_remove, style: primaryTextStyle()),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ).expand()
                        ],
                      ).paddingOnly(bottom: 8).expand()
                    ],
                  ).expand()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
