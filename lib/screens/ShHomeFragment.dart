import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/models/ShCategory.dart';
import 'package:shop_order/models/ShProduct.dart';
import 'package:shop_order/screens/ShSubCategory.dart';
import 'package:shop_order/screens/ShViewAllProducts.dart';
import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShExtension.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';
import 'package:shop_order/utils/dots_indicator/src/dots_decorator.dart';
import 'package:shop_order/utils/dots_indicator/src/dots_indicator.dart';

class ShHomeFragment extends StatefulWidget {
  static String tag = '/ShHomeFragment';

  @override
  ShHomeFragmentState createState() => ShHomeFragmentState();
}

class ShHomeFragmentState extends State<ShHomeFragment> {
  List<ShCategory> list = [];
  List<String> banners = [];
  List<ShProduct> newestProducts = [];
  List<ShProduct> featuredProducts = [];
  var position = 0;
  var colors = [sh_cat_1, sh_cat_2, sh_cat_3, sh_cat_4, sh_cat_5];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    loadCategory().then((categories) {
      setState(() {
        list.clear();
        list.addAll(categories);
      });
    }).catchError((error) {
      toasty(context, error);
    });
    List<ShProduct> products = await loadProducts();
    List<ShProduct> featured = [];
    products.forEach((product) {
      if (product.featured!) {
        featured.add(product);
      }
    });
    List<String> banner = [];
    for (var i = 1; i < 7; i++) {
      banner
          .add("images/shophop/img/products/banners/b" + i.toString() + ".jpg");
    }
    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      banners.clear();
      banners.addAll(banner);
      newestProducts.addAll(products);
      featuredProducts.addAll(featured);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: newestProducts.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height * 0.55,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            PageView.builder(
                              itemCount: banners.length,
                              itemBuilder: (context, index) {
                                return Image.asset(banners[index],
                                    width: width,
                                    height: height * 0.55,
                                    fit: BoxFit.cover);
                              },
                              onPageChanged: (index) {
                                setState(() {
                                  position = index;
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DotsIndicator(
                                dotsCount: banners.length,
                                position: position,
                                decorator: DotsDecorator(
                                  color: sh_view_color,
                                  activeColor: sh_colorPrimary,
                                  size: Size.square(7.0),
                                  activeSize: Size.square(10.0),
                                  spacing: EdgeInsets.all(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        margin: EdgeInsets.only(top: spacing_standard_new),
                        alignment: Alignment.topLeft,
                        child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                              left: spacing_standard, right: spacing_standard),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: spacing_standard,
                                  right: spacing_standard),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(spacing_middle),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors[index % colors.length]),
                                    child: Image.asset(list[index].image!,
                                        width: 15, color: sh_white),
                                  ),
                                  SizedBox(height: spacing_control),
                                  text(list[index].name,
                                      textColor: colors[index % colors.length],
                                      fontFamily: fontMedium)
                                ],
                              ),
                            ).onTap(() {
                              ShSubCategory(category: list[index])
                                  .launch(context);
                            });
                          },
                        ),
                      ),
                      horizontalHeading(sh_lbl_newest_product, callback: () {
                        ShViewAllProductScreen(
                                prodcuts: newestProducts,
                                title: sh_lbl_newest_product)
                            .launch(context);
                      }),
                      ProductHorizontalList(newestProducts),
                      SizedBox(height: spacing_standard_new),
                      horizontalHeading(sh_lbl_Featured, callback: () {
                        ShViewAllProductScreen(
                                prodcuts: featuredProducts,
                                title: sh_lbl_Featured)
                            .launch(context);
                      }),
                      ProductHorizontalList(featuredProducts),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
