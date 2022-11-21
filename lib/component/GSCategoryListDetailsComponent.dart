// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

// Source
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main/utils/AppColors.dart';

// Redirect
import 'package:shop_order/screens/GSRecommendationDetailsScreen.dart';
import 'package:shop_order/main.dart';
// import 'package:shop_order/temp/screens/GSCategoryDetailsScreen.dart';

// ignore: must_be_immutable
class GSCategoryListDetailsComponent extends StatefulWidget {
  static String tag = '/GSCategoryListDetailsComponent';
  List<GSRecommendedModel> categoryDetailsList;

  GSCategoryListDetailsComponent(this.categoryDetailsList, {super.key});

  @override
  GSCategoryListDetailsComponentState createState() =>
      GSCategoryListDetailsComponentState();
}

class GSCategoryListDetailsComponentState
    extends State<GSCategoryListDetailsComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: widget.categoryDetailsList
          .map(
            (mData) => Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
              padding: const EdgeInsets.all(8),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(10),
                backgroundColor: appStore.isDarkModeOn
                    ? scaffoldSecondaryDark
                    : Colors.white,
              ),
              width: context.width() * 0.44,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(mData.image.validate(),
                          fit: BoxFit.cover, height: 120, width: 120)
                      .center(),
                  16.height,
                  Text(
                    mData.title!.validate(),
                    style: boldTextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(mData.quantity.validate(), style: secondaryTextStyle()),
                  12.height,
                  Row(
                    children: [
                      Text(mData.salePrice.validate().round().toVND(),
                          style: secondaryTextStyle(
                              decoration: TextDecoration.lineThrough,
                              size: 16)),
                      8.width,
                      Container(
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radius(4),
                          backgroundColor: primaryColor.withOpacity(0.20),
                        ),
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Text("Save ${mData.offer.validate()}",
                                style: secondaryTextStyle(color: primaryColor))
                            .visible(!mData.offer.isEmptyOrNull),
                      )
                    ],
                  ),
                  Text(mData.price.validate().round().toVND(),
                      style:
                          boldTextStyle(color: Colors.orangeAccent, size: 18)),
                ],
              ),
            ).onTap(() {
              GSRecommendationDetailsScreen(recommendedDetails: mData)
                  .launch(context);
            }),
          )
          .toList(),
    );
  }
}
