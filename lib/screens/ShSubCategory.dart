import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/models/ShCategory.dart';
import 'package:shop_order/models/ShProduct.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShExtension.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';

import 'ShViewAllProducts.dart';

// ignore: must_be_immutable
class ShSubCategory extends StatefulWidget {
  static String tag = '/ShSubCategory';
  ShCategory? category;

  ShSubCategory({this.category});

  @override
  ShSubCategoryState createState() => ShSubCategoryState();
}

class ShSubCategoryState extends State<ShSubCategory> {
  List<String> images = [];
  var currentIndex = 0;
  List<ShProduct> newestProducts = [];
  List<ShProduct> featuredProducts = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData();
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

  fetchData() async {
    List<ShProduct> products = await loadProducts();
    List<ShProduct> categoryProducts = [];
    products.forEach((product) {
      product.categories!.forEach((category) {
        if (category.name == widget.category!.name) {
          categoryProducts.add(product);
        }
      });
    });
    List<ShProduct> featured = [];
    List<String> banner = [];

    categoryProducts.forEach((product) {
      if (product.featured!) {
        featured.add(product);
      }
      if (product.images!.isNotEmpty) {
        banner.add("images/shophop/img/products" + product.images![0].src!);
      }
    });

    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      images.clear();
      if (banner.isNotEmpty) {
        images.addAll(banner);
        currentIndex = 0;
        startTimer();
      }
      newestProducts.addAll(categoryProducts);
      featuredProducts.addAll(featured);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.search,
                  color: appStore.isDarkModeOn ? white : sh_textColorPrimary)),
        ],
        title: Text(
          widget.category!.name!,
          style: boldTextStyle(size: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            images.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: sh_view_color, width: 0.5)),
                    margin: const EdgeInsets.all(spacing_standard_new),
                    child: Image.asset(images[currentIndex],
                        width: double.infinity,
                        height: width * 0.23,
                        fit: BoxFit.cover),
                  )
                : Container(),
            horizontalHeading(sh_lbl_newest_product, callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShViewAllProductScreen(
                          prodcuts: newestProducts,
                          title: sh_lbl_newest_product)));
            }),
            ProductHorizontalList(newestProducts),
            SizedBox(height: spacing_standard_new),
            horizontalHeading(sh_lbl_Featured, callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShViewAllProductScreen(
                          prodcuts: featuredProducts, title: sh_lbl_Featured)));
            }),
            ProductHorizontalList(featuredProducts),
            SizedBox(height: spacing_large),
          ],
        ),
      ),
    );
  }
}
