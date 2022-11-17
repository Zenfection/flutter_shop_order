// ignore_for_file: file_names, deprecated_member_use, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/widget/walk_through.dart';

// Redicrect
import 'GSWelcomeScreen.dart';

// ignore: use_key_in_widget_constructors
class GSWalkThroughScreen extends StatefulWidget {
  static String tag = '/GSWalkThroughScreen';

  @override
  GSWalkThroughScreenState createState() => GSWalkThroughScreenState();
}

// ignore: duplicate_ignore
class GSWalkThroughScreenState extends State<GSWalkThroughScreen>
    // ignore: deprecated_member_use
    with
        AfterLayoutMixin<GSWalkThroughScreen> {
  PageController pageController = PageController();
  List<Widget> pages = [];
  double? currentPage = 0;
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.easeInCubic;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    pages = [
      WalkThroughWidget(
          imageWalkThough[0],
          "Phiên bản mobile của ZenShop\n cho người mua hàng",
          "PHIÊN BẢN DI ĐỘNG"),
      WalkThroughWidget(
          imageWalkThough[1],
          "Mua hàng với thao tác đơn giản \n dành cho người mới",
          "SỬ DỤNG ĐƠN GIẢN"),
      WalkThroughWidget(
          imageWalkThough[2],
          "Thêm sản phẩm vào giỏ hàng\n với nhiều phân loại",
          "GIỎ HÀNG THÔNG MINH"),
      WalkThroughWidget(imageWalkThough[3],
          "Tối ưu hoá đơn giản\n mượt mà từng chi tiết", "TỐC ĐỘ ƯU VIỆT"),
      WalkThroughWidget(imageWalkThough[4],
          "Sử dụng chung API bởi \n web chính thức ZenShop", "API CHÍNH CHỦ"),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    //pageController?.dispose();
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
        key: scaffoldKey,
        body: Stack(
          children: [
            PageView(
                controller: pageController,
                children: pages.map((e) => e).toList()),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "Bỏ Qua".toUpperCase(),
                style: primaryTextStyle(size: 16, color: primaryColor),
                textAlign: TextAlign.end,
              ).onTap(() {
                const GSWelcomeScreen().launch(context);
              }),
            ).paddingOnly(right: 30, top: 30),
            Positioned(
              //  top: context.height() * 0.73,
              bottom: 80,
              left: 0,
              right: 0,
              child: DotIndicator(
                pageController: pageController,
                pages: pages,
                indicatorColor: primaryColor,
                unselectedIndicatorColor: grey,
                currentDotSize: 25,
                currentBoxShape: BoxShape.circle,
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: gsAppButton(
                context,
                'Tiếp Theo',
                () {
                  if (currentPage == pages.length - 1) {
                    finish(context);
                    const GSWelcomeScreen().launch(context);
                  } else {
                    pageController.nextPage(
                        duration: _kDuration, curve: _kCurve);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
