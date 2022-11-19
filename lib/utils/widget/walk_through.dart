// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../GSColors.dart';

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

Widget WalkThroughWidget(String image, String title, String subTitle) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(image.validate(), height: 320, width: 320, fit: BoxFit.cover),
      60.height,
      Column(
        children: [
          Text(title.validate(),
              style: boldTextStyle(size: 20), textAlign: TextAlign.center),
          16.height,
          Text(subTitle.validate(),
              style: secondaryTextStyle(size: 16), textAlign: TextAlign.center),
        ],
      ),
    ],
  );
}
