import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:shop_order/screens/ShHomeScreen.dart';
import 'package:shop_order/screens/ShSignIn.dart';

import 'package:shop_order/utils/ShColors.dart';
import 'package:shop_order/utils/ShConstant.dart';
import 'package:shop_order/utils/ShImages.dart';
import 'package:shop_order/utils/ShStrings.dart';
import 'package:shop_order/utils/ShWidget.dart';
import 'package:shop_order/utils/widgets/ShSliderWidget.dart';

import 'package:shop_order/utils/dots_indicator/src/dots_decorator.dart';
import 'package:shop_order/utils/dots_indicator/src/dots_indicator.dart';

class ShWalkThroughScreen extends StatefulWidget {
  static var tag = "/ShWalkThroughScreen";

  @override
  _ShWalkThroughScreenState createState() => _ShWalkThroughScreenState();
}

class _ShWalkThroughScreenState extends State<ShWalkThroughScreen> {
  var mSliderList = <String>[ic_walk_1, ic_walk_2, ic_walk_3];
  var mHeadingList = <String>[
    "Hi, Welcome",
    "Most Unique Styles!",
    "Shop Till You Drop!"
  ];
  var mSubHeadingList = <String>[
    "We make around your city Affordable,easy and efficient.",
    "Shop the most trending fashion on the biggest shopping website",
    "Grab the best seller pieces at bargain prices."
  ];
  var position = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              24.height,
              Container(
                margin: EdgeInsets.fromLTRB(spacing_large, spacing_large,
                    spacing_large, spacing_standard_new),
                child: Column(
                  children: <Widget>[
                    Text(mHeadingList[position],
                        style: boldTextStyle(size: 24)),
                    16.height,
                    Text(
                      mSubHeadingList[position],
                      style: secondaryTextStyle(size: 16),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ShCarouselSlider(
                viewportFraction: 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                items: mSliderList.map(
                  (slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(spacing_standard))),
                          margin: EdgeInsets.all(spacing_standard_new),
                          child: Image.asset(slider,
                                  width: context.width(), fit: BoxFit.cover)
                              .center(),
                        );
                      },
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  position = index;
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.all(spacing_large),
                child: Column(
                  children: <Widget>[
                    DotsIndicator(
                      dotsCount: 3,
                      position: position,
                      decorator: DotsDecorator(
                        color: sh_view_color,
                        activeColor: sh_colorPrimary,
                        activeSize: Size.square(14.0),
                        spacing: EdgeInsets.all(spacing_control),
                      ),
                    ),
                    16.height,
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: MaterialButton(
                        padding: EdgeInsets.all(spacing_standard),
                        child: Text(sh_text_start_to_shopping,
                            style: TextStyle(fontSize: 18)),
                        textColor: sh_white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)),
                        color: sh_colorPrimary,
                        onPressed: () {
                          finish(context);
                          ShHomeScreen().launch(context);
                        },
                      ),
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(sh_lbl_already_have_a_account,
                            style: primaryTextStyle(color: gray)),
                        Text(sh_lbl_sign_in, style: boldTextStyle()),
                      ],
                    ).onTap(
                      () {
                        ShSignIn().launch(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShSliderWidget extends StatelessWidget {
  var mSliderList = <String>[ic_walk_1, ic_walk_2, ic_walk_3];

  ShSliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final Size cardSize = Size(width, width / 1.8);

    return ShCarouselSlider(
      viewportFraction: 0.9,
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: cardSize.height,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(
                        BuildContext, String)?,
                    imageUrl: slider,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: cardSize.height),
              ),
            );
          },
        );
      }).toList(),
      onPageChanged: (index) {},
    );
  }
}
