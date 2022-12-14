// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_order/main.dart';

import 'package:shop_order/component/GSRecommendedListComponent.dart';
import 'package:shop_order/component/GSCategoryListComponent.dart';

// Redicrect
import 'GSCategoryListDetailsScreen.dart';
// import '../temp/screens/GSNotificationScreen.dart';

class GSDashboardScreen extends StatefulWidget {
  static String tag = '/GSDashboardScreen';

  const GSDashboardScreen({super.key});

  @override
  GSDashboardScreenState createState() => GSDashboardScreenState();
}

class GSDashboardScreenState extends State<GSDashboardScreen> {
  List<SliderModel> sliderList = getSliderList();
  List<CategoryModel> categoryList = getCategoryList();
  List<GSRecommendedModel> listTopDiscount = [];
  List<GSRecommendedModel> listTopRanking = [];

  final IconData _iconDark = FontAwesomeIcons.moon;
  final IconData _iconLight = FontAwesomeIcons.lightbulb;
  bool? _isDark = false;

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
    _isDark = prefs.getBool('DarkModePref')!;
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

  Future refresh() async {
    listTopDiscount = await getTopDiscount(10);
    listTopRanking = await getTopRanking(10);
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
                  Text(zenAppName, style: boldTextStyle()),
                ],
              ).paddingLeft(16),
              IconButton(
                icon: FaIcon(
                  _isDark! ? _iconDark : _iconLight,
                  color: _isDark! ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  darktoggle(context);
                  setState(() {
                    _isDark = !_isDark!;
                  });
                  // const GSNotificationScreen().launch(context);
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
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
                            hintText: "T??m ki???m s???n ph???m",
                            hintStyle: secondaryTextStyle(
                                size: 18, color: Colors.grey),
                          ),
                        ).expand(),
                        const IconButton(
                          icon: Icon(Icons.search),
                          onPressed: null, //! ??ang ph??t tri???n
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
                      Text("Gi???m Gi?? Nhi???u", style: boldTextStyle(size: 18)),
                      Text("Xem Th??m",
                              style:
                                  boldTextStyle(color: primaryColor, size: 16))
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
                      Text("????nh Gi?? Cao", style: boldTextStyle(size: 18)),
                      Text("Xem Th??m",
                              style:
                                  boldTextStyle(color: primaryColor, size: 16))
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
      ),
    );
  }

  void darktoggle(BuildContext context) async {
    hideKeyboard(context);
    final prefs = await SharedPreferences.getInstance();
    bool? isDarkModeOn = prefs.getBool('DarkModePref');
    prefs.setBool('DarkModePref', !isDarkModeOn!);
    appStore.toggleDarkMode(value: !isDarkModeOn);
  }
}
