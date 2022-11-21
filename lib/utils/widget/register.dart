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
