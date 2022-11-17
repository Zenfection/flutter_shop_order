import 'package:flutter/material.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/screens/GSRecommendationDetailsScreen.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

// ignore: must_be_immutable
class GSRecommendedListComponent extends StatefulWidget {
  static String tag = '/GSRecommendedListComponent';
  List<GSRecommendedModel> recommendedList;

  GSRecommendedListComponent(this.recommendedList, {super.key});

  @override
  GSRecommendedListComponentState createState() =>
      GSRecommendedListComponentState();
}

class GSRecommendedListComponentState
    extends State<GSRecommendedListComponent> {
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
    return SizedBox(
      height: 260,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: 16),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.recommendedList.length,
        itemBuilder: (context, index) {
          GSRecommendedModel mData = widget.recommendedList[index];
          return Container(
            width: 200,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(8),
              backgroundColor:
                  appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
              boxShadow: defaultBoxShadow(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(mData.image.validate(),
                            fit: BoxFit.cover, height: 120, width: 120)
                        .center(),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 4, bottom: 4),
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radius(5),
                          backgroundColor: Colors.redAccent),
                      child: Text("${mData.offer.validate()}%",
                          style: boldTextStyle(size: 13, color: Colors.white)),
                    ).visible(!mData.offer.isEmptyOrNull),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    Text(mData.price.validate().round().toVND(),
                        style: boldTextStyle(color: primaryColor, size: 18)),
                    8.width,
                    Text(mData.salePrice.validate().round().toVND(),
                        style: secondaryTextStyle(
                            size: 16, decoration: TextDecoration.lineThrough)),
                  ],
                ),
                4.height,
                Text(mData.title.validate(),
                    style: boldTextStyle(size: 16), maxLines: 1),
                Text(mData.quantity!, style: secondaryTextStyle(size: 15))
              ],
            ),
          ).onTap(() {
            GSRecommendationDetailsScreen(recommendedDetails: mData)
                .launch(context);
          }).paddingOnly(left: 16);
        },
      ),
    );
  }
}
