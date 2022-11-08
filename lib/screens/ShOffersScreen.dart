import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/main.dart';
import 'package:shop_hop_prokit/models/ShProduct.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShExtension.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

import 'ShProductDetail.dart';

class ShOffersScreen extends StatefulWidget {
  static String tag = '/ShOffersScreen';

  @override
  ShOffersScreenState createState() => ShOffersScreenState();
}

class ShOffersScreenState extends State<ShOffersScreen> {
  List<ShProduct> mProductModel = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();
    List<ShProduct> offers = [];
    products.forEach((product) {
      if (product.on_sale!) {
        offers.add(product);
      }
    });
    setState(() {
      mProductModel.clear();
      mProductModel.addAll(offers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gridView = Container(
      child: GridView.builder(
          itemCount: mProductModel.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(spacing_middle),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 13, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_standard_new),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                ShProductDetail(product: mProductModel[index]).launch(context);
              },
              child: Container(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 9 / 11,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                            child: Image.asset(
                              "images/shophop/img/products" + mProductModel[index].images![0].src!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spacing_control),
                            margin: EdgeInsets.all(spacing_standard),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: context.cardColor),
                            child: Icon(
                              Icons.favorite_border,
                              color: appStore.isDarkModeOn ? white : sh_textColorPrimary,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    2.height,
                    Row(
                      children: <Widget>[
                        text(mProductModel[index].on_sale! ? mProductModel[index].sale_price.toString().toCurrencyFormat() : mProductModel[index].price.toString().toCurrencyFormat(),
                            textColor: sh_colorPrimary, fontFamily: fontMedium, fontSize: textSizeNormal),
                        4.width,
                        Text(
                          mProductModel[index].regular_price.toString().toCurrencyFormat()!,
                          style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium, decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(sh_lbl_my_offers, style: boldTextStyle(size: 18)),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actionsIconTheme: IconThemeData(color: sh_colorPrimary),
        actions: [
          cartIcon(context, 3),
        ],
      ),
      body: gridView,
    );
  }
}
