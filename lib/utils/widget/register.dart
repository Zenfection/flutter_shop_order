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
