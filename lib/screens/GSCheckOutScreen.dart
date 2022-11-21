// ignore_for_file: file_names

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Source
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/screens/GSRecommendationDetailsScreen.dart';
import 'package:shop_order/utils/AppConstants.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSDataProvider.dart';

// Redirect
import 'GSSuccessfulOrderScreen.dart';
// import 'package:shop_order/temp/screens/GSPaymentScreen.dart';

class GSCheckOutScreen extends StatefulWidget {
  static String tag = '/GSCheckOutScreen';

  const GSCheckOutScreen({super.key});

  @override
  GSCheckOutScreenState createState() => GSCheckOutScreenState();
}

class GSCheckOutScreenState extends State<GSCheckOutScreen> {
  List<User> userInfo = [];
  List<GSRecommendedModel> orderProductList = [];
  String fullname = '';
  String phone = '';
  String address = '';
  String email = '';
  double totalMoney = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    var data = await getUserInfo(username, password);
    var dataProduct = await getUserCart(username, password);
    setState(() {
      userInfo = data;
      fullname = userInfo[0].fullname!;
      phone = userInfo[0].phone;
      address = userInfo[0].address;
      email = userInfo[0].email!;
      orderProductList = dataProduct;
    });
    calculate();
  }

  calculate() async {
    totalMoney = 0;
    for (var element in orderProductList) {
      setState(() {
        totalMoney +=
            ((element.salePrice.validate()) * (element.qty.validate())).toInt();
      });
    }
  }

  Widget rowWidget(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        8.width,
        Text(title, style: primaryTextStyle()).expand(),
        const Icon(Icons.navigate_next_outlined, color: primaryColor),
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          appStore.isDarkModeOn ? scaffoldColorDark : gs_background,
      appBar:
          gsStatusBarWithTitle(context, "Thanh Toán") as PreferredSizeWidget?,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Thông tin giao hàng", style: secondaryTextStyle(size: 16))
                    .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  color: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(mapImage,
                          fit: BoxFit.cover, height: 90, width: 90),
                      16.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fullname, style: primaryTextStyle(size: 14)),
                          4.height,
                          Text(phone, style: primaryTextStyle(size: 14)),
                          Text(email, style: primaryTextStyle(size: 14)),
                        ],
                      ).expand()
                    ],
                  ),
                ),
                8.height,
                Text("Thời gian Đặt Hàng", style: secondaryTextStyle(size: 16))
                    .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                8.height,
                Container(
                  color: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      rowWidget(
                              Icons.schedule,
                              DateFormat('EEE, d MMM yyyy - kk:mm')
                                  .format(DateTime.now()))
                          .onTap(() {}),
                    ],
                  ),
                ),
                8.height,
                Text("Thông tin sản phẩm", style: secondaryTextStyle(size: 16))
                    .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                8.height,
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ListView.separated(
                    separatorBuilder: (_, i) => const Divider(),
                    shrinkWrap: true,
                    reverse: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: orderProductList.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) {
                      GSRecommendedModel mData = orderProductList[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  GSRecommendationDetailsScreen(
                                          recommendedDetails: mData)
                                      .launch(context);
                                },
                                child: Ink.image(
                                  image: AssetImage(mData.image.validate()),
                                  // fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              30.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${mData.title.validate()} x ${mData.qty}',
                                      style: boldTextStyle(size: 17),
                                      maxLines: 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        mData.price.validate().round().toVND(),
                                        style: secondaryTextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            size: 14),
                                      ),
                                      8.width,
                                      Text(
                                          mData.salePrice
                                              .validate()
                                              .round()
                                              .toVND(),
                                          style: boldTextStyle(
                                              color: redColor, size: 16)),
                                    ],
                                  ),
                                  10.height,
                                ],
                              ),
                            ],
                          )
                        ],
                      ).onTap(() {});
                    },
                  ),
                ),
                Text("Giá Tiền", style: secondaryTextStyle(size: 16))
                    .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                8.height,
                Container(
                  color: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text("Tổng Tiền", style: boldTextStyle()).expand(),
                      Text(totalMoney.round().toVND(), style: boldTextStyle()),
                    ],
                  ),
                ),
                8.height,
                Text("Phương Thức Thanh Toán",
                        style: secondaryTextStyle(size: 16))
                    .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                8.height,
                Container(
                  color: appStore.isDarkModeOn
                      ? scaffoldSecondaryDark
                      : Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: rowWidget(Icons.payment, "Chức năng đang phát triển")
                      .onTap(() {
                    // GSPaymentScreen().launch(context);
                  }),
                ),
                8.height,
                // Text("Promo Code", style: secondaryTextStyle(size: 16))
                //     .paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                // 8.height,
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   color: appStore.isDarkModeOn
                //       ? scaffoldSecondaryDark
                //       : Colors.white,
                //   child: Row(
                //     children: [
                //       Image.asset(gs_coupon,
                //           height: 24, width: 24, color: primaryColor),
                //       8.width,
                //       Text("Add Promo Code", style: primaryTextStyle())
                //           .expand(),
                //       const Icon(Icons.navigate_next_outlined,
                //           color: primaryColor),
                //     ],
                //   ),
                // ),
              ],
            ),
          ).expand(),
          gsAppButton(context, "Đặt Hàng", () {
            checkOut(context);
          })
        ],
      ),
    );
  }
}

checkOut(var context) async {
  final prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  String? password = prefs.getString('password');
  var uri = Uri.parse('$baseUrl/checkout');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
  });

  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      prefs.remove('order_pending');
      List<GSMyOrderModel> pendingOrderList =
          await getOrderStatus(username!, password!, 'pending');
      prefs.setString('order_pending', jsonEncode(pendingOrderList));
      const GSSuccessfulOrderScreen().launch(context);
    } else {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } else {
    Fluttertoast.showToast(
        msg: "Lỗi kết nối API",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
