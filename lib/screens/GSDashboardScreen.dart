// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/main/store/AppStore.dart';
// import 'package:shop_order/main.dart';

import 'package:shop_order/component/GSRecommendedListComponent.dart';
import 'package:shop_order/component/GSCategoryListComponent.dart';

// Redicrect
import 'GSCategoryListDetailsScreen.dart';
import 'GSNotificationScreen.dart';

class GSDashboardScreen extends StatefulWidget {
  static String tag = '/GSDashboardScreen';

  const GSDashboardScreen({super.key});

  @override
  GSDashboardScreenState createState() => GSDashboardScreenState();
}

class GSDashboardScreenState extends State<GSDashboardScreen> {
  AppStore appStore = AppStore();
  List<SliderModel> sliderList = getSliderList();
  List<CategoryModel> categoryList = getCategoryList();
  List<GSRecommendedModel> listTopDiscount = [];
  List<GSRecommendedModel> listTopRanking = [];

  int currentIndexPage = 0;
  PageController pageController =
      PageController(viewportFraction: 0.92, initialPage: 0);

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('top_discount')) {
      String topDiscount = prefs.getString('top_discount')!;
      try {
        List data = jsonDecode(topDiscount);
        listTopDiscount
            .addAll(data.map((e) => GSRecommendedModel.fromJson(e)).toList());
      } catch (e) {
        listTopDiscount = await getTopDiscount(10);
      }
    } else {
      listTopDiscount = await getTopDiscount(10);
    }

    if (prefs.containsKey('top_ranking')) {
      String topRanking = prefs.getString('top_ranking')!;
      try {
        List data = jsonDecode(topRanking);
        listTopRanking
            .addAll(data.map((e) => GSRecommendedModel.fromJson(e)).toList());
      } catch (e) {
        listTopRanking = await getTopRanking(10);
      }
    } else {
      listTopRanking = await getTopRanking(10);
    }
    setState(() {
      listTopDiscount = listTopDiscount;
      listTopRanking = listTopRanking;
    });
  }

  @override
  void dispose() {
    //pageController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
          elevation: 1,
          centerTitle: false,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(avatarLogo,
                      height: 50, width: 50, fit: BoxFit.cover),
                  8.width,
                  Text(GSAppName, style: boldTextStyle()),
                ],
              ).paddingLeft(16),
              IconButton(
                icon: Icon(Icons.notifications_none_sharp,
                    color: appStore.isDarkModeOn
                        ? iconSecondaryColor
                        : Colors.black),
                onPressed: () {
                  hideKeyboard(context);
                  const GSNotificationScreen().launch(context);
                },
              ),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radius(8),
                    backgroundColor: appStore.isDarkModeOn
                        ? scaffoldSecondaryDark
                        : Colors.grey[50]!,
                  ),
                  child: Row(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tìm kiếm sản phẩm",
                          hintStyle:
                              secondaryTextStyle(size: 18, color: Colors.grey),
                        ),
                      ).expand(),
                      const IconButton(
                        icon: Icon(Icons.search),
                        onPressed: null, //! đang phát triển
                      ),
                    ],
                  ),
                ).paddingOnly(left: 16, right: 16, top: 16),
                16.height,
                SizedBox(
                  height: 240,
                  width: context.width(),
                  child: PageView.builder(
                    pageSnapping: false,
                    itemCount: sliderList.length,
                    controller: pageController,
                    onPageChanged: (int index) =>
                        setState(() => currentIndexPage = index),
                    itemBuilder: (_, index) {
                      return Image.asset(
                        sliderList[index].image.validate(),
                        fit: BoxFit.cover,
                        //height: 240,
                        width: context.width(),
                      ).cornerRadiusWithClipRRect(4).paddingRight(16);
                    },
                  ),
                ),
                8.height,
                Container(
                  alignment: Alignment.bottomCenter,
                  width: context.width(),
                  child: DotIndicator(
                    currentDotSize: 20,
                    dotSize: 10,
                    pageController: pageController,
                    pages: sliderList,
                    indicatorColor: primaryColor,
                    unselectedIndicatorColor: Colors.grey,
                  ),
                ),
                16.height,
                GSCategoryListComponent(categoryList)
                    .paddingOnly(left: 16, right: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Giảm Giá Nhiều", style: boldTextStyle(size: 18)),
                    Text("Xem Thêm",
                            style: boldTextStyle(color: primaryColor, size: 16))
                        .onTap(() {
                      GSCategoryListDetailsScreen().launch(context);
                    })
                  ],
                ).paddingOnly(left: 16, right: 16, top: 16),
                8.height,
                GSRecommendedListComponent(listTopDiscount),
                8.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Đánh Giá Cao", style: boldTextStyle(size: 18)),
                    Text("Xem Thêm",
                            style: boldTextStyle(color: primaryColor, size: 16))
                        .onTap(() {
                      GSCategoryListDetailsScreen().launch(context);
                    })
                  ],
                ).paddingOnly(left: 16, right: 16),
                8.height,
                GSRecommendedListComponent(listTopRanking),
              ],
            ).paddingBottom(16),
          ],
        ),
      ),
    );
  }
}
