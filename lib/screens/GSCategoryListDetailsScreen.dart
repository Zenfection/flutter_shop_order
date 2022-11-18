import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_order/component/GSCategoryListDetailsComponent.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class GSCategoryListDetailsScreen extends StatefulWidget {
  static String tag = '/GSCategoryListDetailsScreen';
  String? categoryName;

  GSCategoryListDetailsScreen({super.key, this.categoryName});

  @override
  GSCategoryListDetailsScreenState createState() =>
      GSCategoryListDetailsScreenState();
}

getCategoryCode(category) {
  if (category == 'Bánh') {
    return 'cake';
  } else if (category == 'Kẹo') {
    return 'candy';
  } else if (category == 'Đồ Chiên') {
    return 'fastfood';
  } else if (category == 'Trái Cây') {
    return 'fruit';
  } else if (category == 'Kem') {
    return 'icecream';
  }
}

class GSCategoryListDetailsScreenState
    extends State<GSCategoryListDetailsScreen> {
  List<GSRecommendedModel> categoryDetailsList = [];

  List<Map<String, String>> filterList = [
    {'title': "Giá thành"},
    {'title': "Loại sản phẩm"},
    {'title': "Sản phẩm mới"},
  ];
  List<Map<String, String>> sortList = [
    {'title': "Mặc định"},
    {'title': "Bán Chạy"},
    {'title': "Giá tăng dần"},
    {'title': "Giá giảm dần"},
    {'title': "Giảm giá nhiều"},
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    String category = widget.categoryName!;
    category = getCategoryCode(category);

    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("${category}_product")) {
      String categoryDetails = prefs.getString("${category}_product")!;
      try {
        List data = jsonDecode(categoryDetails);
        categoryDetailsList
            .addAll(data.map((e) => GSRecommendedModel.fromJson(e)).toList());
      } catch (e) {
        categoryDetailsList = await getCategoryProduct(category);
      }
    } else {
      categoryDetailsList = await getCategoryProduct(category);
    }
    setState(() {});
  }

  Future refresh() async {
    String category = widget.categoryName!;
    category = getCategoryCode(category);

    final prefs = await SharedPreferences.getInstance();
    categoryDetailsList = await getCategoryProduct(category);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : gs_background,
        appBar: AppBar(
          backgroundColor:
              appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
          elevation: 1,
          centerTitle: false,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      appStore.isDarkModeOn ? iconSecondaryColor : Colors.black,
                ),
                onPressed: () {
                  finish(context);
                },
              ),
              8.width,
              Text(widget.categoryName.validate(), style: boldTextStyle())
                  .expand(),
              IconButton(icon: const Icon(Icons.share), onPressed: () {})
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          //padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(0),
                  boxShadow: defaultBoxShadow(),
                  backgroundColor: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.filter_alt, color: Colors.grey),
                        8.width,
                        Text("Bộ Lọc", style: secondaryTextStyle(size: 16)),
                      ],
                    ).onTap(() {
                      bottomFilterDialog(
                          context, "Bộ lọc thông minh", filterList);
                    }),
                    Row(
                      children: [
                        const Icon(Icons.sort, color: Colors.grey),
                        8.width,
                        Text("Sắp Xếp", style: secondaryTextStyle(size: 16)),
                      ],
                    ).onTap(() {
                      bottomFilterDialog(context, "Sắp Xếp", sortList);
                    })
                  ],
                ),
              ),
              GSCategoryListDetailsComponent(categoryDetailsList)
            ],
          ),
        ),
      ),
    );
  }
}
