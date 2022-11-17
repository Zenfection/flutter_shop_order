// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/store/AppStore.dart';
import 'package:shop_order/utils/GSDataProvider.dart';

// Redirect
// import 'GSAddressScreen.dart';
import 'GSEditProfileScreen.dart';
import 'GSLoginScreen.dart';
// import '../temp/screens/GSHelpScreen.dart';
// import '../temp/screens/GSPromoScreen.dart';

class GSAccountScreen extends StatefulWidget {
  static String tag = '/GSAccountScreen';

  const GSAccountScreen({super.key});

  @override
  GSAccountScreenState createState() => GSAccountScreenState();
}

class GSAccountScreenState extends State<GSAccountScreen> {
  File? profileImage;
  String fullname = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    var data = await getUserInfo(username, password);
    setState(() {
      fullname = data[0].fullname;
      email = data[0].email;
    });
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Thay đổi Avatar',
            style: primaryTextStyle(size: 20, weight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chụp Ảnh', style: primaryTextStyle(size: 16)).onTap(() {
                pickFromCamera();
                finish(context);
              }),
              20.height,
              Text('Chọn ảnh thư viện', style: primaryTextStyle(size: 16))
                  .onTap(() {
                pickFromGallery();
                finish(context);
              }),
            ],
          ),
        );
      },
    );
  }

  pickFromCamera() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 50))!
        .path);
    setState(() {
      profileImage = image;
    });
  }

  pickFromGallery() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.gallery, imageQuality: 50))!
        .path);

    setState(() {
      profileImage = image;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("Tài khoản", style: boldTextStyle(size: 20)),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImage != null
                ? Image.file(profileImage!,
                        width: 110, height: 110, fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(60)
                    .center()
                : Image.asset(
                    profileImage != null ? profileImage as String : avatarLogo,
                    width: 110,
                    height: 110,
                    fit: BoxFit.fill,
                  ).cornerRadiusWithClipRRect(60).center().paddingTop(16),
            8.height,
            Text(fullname, style: boldTextStyle(size: 18)),
            Text(email, style: secondaryTextStyle()),
            16.height,
            AppButton(
              color: primaryColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.edit_outlined, color: Colors.white),
                  8.width,
                  Text("Thay đổi Avatar",
                      style: boldTextStyle(color: Colors.white, size: 14)),
                ],
              ).paddingOnly(left: 16, right: 16),
              onTap: () {
                dialogWidget(context);
              },
            ),
            40.height,
            profileWidget(
                    "Thông tin cá nhân", "Chứa các thông tin cơ bản của bạn")
                .onTap(() {
              const GSEditProfileScreen().launch(context);
            }),
            // profileWidget("Promos", "Latest Promos from us").onTap(() {
            //   GSPromoScreen().launch(context);
            // }),
            profileWidget("Địa chỉ giao hàng",
                    "Tổng hợp các địa chỉ giao hàng của bạn")
                .onTap(() {
              // GSAddressScreen().launch(context);
            }),
            // profileWidget(
            //         "Terms, Privacy, & Policy", "Things you may want to know")
            //     .onTap(() {}),
            // profileWidget("Help & Support", "Get support from Us").onTap(() {
            //   GSHelpScreen().launch(context);
            // }),
            8.height,
            profileWidget("Đăng xuất", "Thoát khỏi tài khoản").onTap(() {
              logout(context);
            }),
          ],
        ),
      ).paddingBottom(16),
    );
  }
}

logout(var context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AppStore appStore = AppStore();
  prefs.remove('username');
  prefs.remove('password');
  appStore.isLoggedIn = false;
  const GSLoginScreen().launch(context, isNewTask: true);
}
