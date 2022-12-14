// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/main.dart';

// Redirect
import 'GSEditProfileScreen.dart';
import 'GSLoginScreen.dart';
// import 'GSAddressScreen.dart';
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
  late List user;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    if (prefs.containsKey('user_info')) {
      String userInfo = prefs.getString('user_info')!;
      try {
        var data = jsonDecode(userInfo);
        fullname = data['fullname'];
        email = data['email'];
        // userList.addAll(data.map((e) => User.fromJson(e)).toList());
      } catch (e) {
        toast(e.toString());
      }
    } else {
      var data = await getUserInfo(username, password);
      fullname = data[0].fullname!;
      email = data[0].email!;
    }
    setState(() {
      fullname = fullname;
      email = email;
    });
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Thay ?????i Avatar',
            style: primaryTextStyle(size: 20, weight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ch???p ???nh', style: primaryTextStyle(size: 16)).onTap(() {
                pickFromCamera();
                finish(context);
              }),
              20.height,
              Text('Ch???n ???nh th?? vi???n', style: primaryTextStyle(size: 16))
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

  Future refresh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;

    var data = await getUserInfo(username, password);
    fullname = data[0].fullname!;
    email = data[0].email!;

    setState(() {
      fullname = fullname;
      email = email;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("T??i kho???n", style: boldTextStyle(size: 20)),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileImage != null
                  ? Image.file(profileImage!,
                          width: 110, height: 110, fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(60)
                      .center()
                  : Image.asset(
                      profileImage != null
                          ? profileImage as String
                          : avatarLogo,
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
                    Text("Thay ?????i Avatar",
                        style: boldTextStyle(color: Colors.white, size: 14)),
                  ],
                ).paddingOnly(left: 16, right: 16),
                onTap: () {
                  dialogWidget(context);
                },
              ),
              40.height,
              profileWidget(
                      "Th??ng tin c?? nh??n", "Ch???a c??c th??ng tin c?? b???n c???a b???n")
                  .onTap(() {
                const GSEditProfileScreen().launch(context);
              }),
              // profileWidget("Promos", "Latest Promos from us").onTap(() {
              //   GSPromoScreen().launch(context);
              // }),
              profileWidget("?????a ch??? giao h??ng",
                      "T???ng h???p c??c ?????a ch??? giao h??ng c???a b???n")
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
              profileWidget("????ng xu???t", "Tho??t kh???i t??i kho???n").onTap(() {
                logout(context);
              }),
            ],
          ),
        ).paddingBottom(16),
      ),
    );
  }
}

logout(var context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');
  prefs.remove('password');
  prefs.remove('user_cart');
  prefs.remove('order_pending');
  prefs.remove('order_shipping');
  prefs.remove('order_delivered');
  prefs.remove('order_cancelled');
  prefs.remove('user_info');
  prefs.remove('isLogged');

  const GSLoginScreen().launch(context, isNewTask: true);
}
