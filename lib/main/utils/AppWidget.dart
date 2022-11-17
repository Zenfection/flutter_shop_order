// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/models/AppModel.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

Widget commonCacheImageWidget(String? url, double? height,
    {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.network(url!, height: height, width: width, fit: fit);
    }
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit);
  }
}

Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('assets/grey.jpg', fit: BoxFit.cover);

InputDecoration inputDecoration({String? label, String? prefixText}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
          color: appStore.isDarkModeOn ? Colors.white30 : Colors.grey[200]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
          color: appStore.isDarkModeOn ? Colors.white30 : Colors.grey[300]!),
    ),
    filled: true,
    fillColor: appStore.isDarkModeOn ? Colors.white12 : Colors.grey[100],
    labelText: label,
    labelStyle: secondaryTextStyle(),
    prefixText: prefixText,
    alignLabelWithHint: true,
  );
}

class ExampleItemWidget extends StatelessWidget {
  final AppModel tabBarType;
  final Function onTap;
  final bool showTrailing;

  ExampleItemWidget(this.tabBarType,
      {required this.onTap, this.showTrailing = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appStore.isDarkModeOn ? appStore.cardColor : appBarBackgroundColor,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      elevation: 2.0,
      shadowColor: Colors.black,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(tabBarType.title!,
            style: appStore.isDarkModeOn ? boldTextStyle() : boldTextStyle()),
        trailing: showTrailing
            ? const Icon(Icons.arrow_forward_ios,
                size: 15, color: textPrimaryColor)
            : null,
      ),
    );
  }
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? appBarBackgroundColor,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}
