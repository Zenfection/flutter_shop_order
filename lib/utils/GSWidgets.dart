// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:shop_order/model/GSModel.dart';
// import 'package:shop_order/screens/GSOrderProgressDetailsScreen.dart';
// import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

/*
* gsAppButton, InputDecoration, myOrderWidget, cartNotFound, profileWidget
*/

Widget gsAppButton(BuildContext context, String title, Function onTap) {
  return AppButton(
    width: context.width(),
    color: primaryColor,
    shapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    onTap: onTap,
    child: Text(title, style: boldTextStyle(color: Colors.white, size: 20)),
  );
}

InputDecoration inputDecoration({String? label, String? error}) {
  return InputDecoration(
    enabledBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
    labelText: label,
    labelStyle: secondaryTextStyle(size: 14),
    errorText: error,
    errorBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  );
}

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    Key? key,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String? title;
  final String? message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title!,
              style: boldTextStyle(),
            ),
          ],
        ).paddingLeft(16),
      ],
    );
  }
}

Widget profileWidget(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: boldTextStyle()),
          Text(description, style: secondaryTextStyle()),
        ],
      ),
      Image.asset(nextImage,
          height: 20, width: 20, fit: BoxFit.cover, color: primaryColor)
    ],
  ).paddingOnly(top: 8, bottom: 8, left: 16, right: 16);
}

Widget helpWidget(String title, String image) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: boldTextStyle()),
      Image.asset(image, height: 20, width: 20, color: primaryColor),
    ],
  ).paddingAll(16);
}

Widget gsStatusBarWithTitle(BuildContext context, String title) {
  return AppBar(
    backgroundColor: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
    elevation: 1,
    centerTitle: false,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appStore.isDarkModeOn ? iconSecondaryColor : Colors.black,
          ),
          onPressed: () {
            finish(context);
          },
        ),
        8.width,
        Text(title, style: boldTextStyle()),
      ],
    ),
  );
}

bottomFilterDialog(BuildContext context, String title, List list,
    {int tappedIndex = 0}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), topLeft: Radius.circular(16))),
    context: context,
    builder: (BuildContext context) {
      return BottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        )),
        onClosing: () {},
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: boldTextStyle(size: 18)),
                      16.height,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(list.length, (index) {
                          return Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  list[index]['title'],
                                  style: primaryTextStyle(),
                                ).expand(),
                                tappedIndex == index
                                    ? Image.asset(
                                        nextImage,
                                        color: primaryColor,
                                        height: 18,
                                        width: 18,
                                      )
                                    : Container()
                              ],
                            ),
                          ).onTap(() {
                            setState(() {
                              tappedIndex = index;
                            });
                          });
                        }),
                      )
                    ],
                  ).paddingAll(16));
        },
      );
    },
  );
}
