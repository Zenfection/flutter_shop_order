import 'package:flutter/material.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/screens/GSCategoryListDetailsScreen.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class GSCategoryListComponent extends StatefulWidget {
  static String tag = '/GSCategoryListComponent';
  List<CategoryModel> categoryList;

  GSCategoryListComponent(this.categoryList, {super.key});

  @override
  GSCategoryListComponentState createState() => GSCategoryListComponentState();
}

class GSCategoryListComponentState extends State<GSCategoryListComponent> {
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
      runSpacing: 16,
      spacing: 16,
      children: widget.categoryList.map((e) {
        return Container(
          width: context.width() * 0.27,
          padding: const EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(4),
            border: Border.all(color: Colors.grey[200]!),
            backgroundColor:
                appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(e.image!, fit: BoxFit.cover, height: 80, width: 80),
              8.height,
              Text(e.catgoryName!,
                  style: primaryTextStyle(size: 15),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ).onTap(() {
          GSCategoryListDetailsScreen(categoryName: e.catgoryName)
              .launch(context);
        });
      }).toList(),
    );
  }
}
