// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/main/models/AppModel.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/AppConstants.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  late String userExist;

  @observable
  bool isDarkModeOn = false;

  @observable
  bool isLoggedIn = false;

  List<GSRecommendedModel> listTopDiscount = [];

  @observable
  Color cardColor = Colors.white;

  @action
  void setLoggedIn(bool val) {
    isLoggedIn = val;
  }

  @action
  Future<void> toggleDarkMode({bool? value}) async {
    isDarkModeOn = value.validate(value: !isDarkModeOn);

    if (isDarkModeOn) {
      textPrimaryColorGlobal = whiteColor;
      textSecondaryColorGlobal = Colors.white54;

      cardColor = scaffoldSecondaryDark;

      shadowColorGlobal = Colors.white12;
      setStatusBarColor(Colors.black,
          statusBarIconBrightness: Brightness.light);

      defaultLoaderBgColorGlobal = Colors.black;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      cardColor = Colors.white;

      shadowColorGlobal = Colors.black12;
      setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);

      defaultLoaderBgColorGlobal = Colors.white;
    }

    setValue(DarkModePref, isDarkModeOn);
  }
}
