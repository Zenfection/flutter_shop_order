// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Source
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/utils/AppWidget.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/AppConstants.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main.dart';

// Redicrect
import 'GSCheckOutScreen.dart';
import 'GSRecommendationDetailsScreen.dart';

class GSCartScreen extends StatefulWidget {
  static String tag = '/GSCartScreen';

  const GSCartScreen({super.key});

  @override
  GSCartScreenState createState() => GSCartScreenState();
}

class GSCartScreenState extends State<GSCartScreen> {
  List<GSRecommendedModel> recommendedList = [];
  int totalCount = 0;
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;

    if (prefs.containsKey('user_cart')) {
      String userCart = prefs.getString('user_cart')!;
      try {
        List data = jsonDecode(userCart);
        recommendedList
            .addAll(data.map((e) => GSRecommendedModel.fromJson(e)).toList());
      } catch (e) {
        recommendedList = await getUserCart(username, password);
      }
    } else {
      recommendedList = await getUserCart(username, password);
    }

    setState(() {
      recommendedList = recommendedList;
      calculate();
    });
  }

  Future refesh() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    recommendedList = await getUserCart(username, password);
    prefs.remove('user_cart');
    prefs.setString('user_cart', jsonEncode(recommendedList));

    setState(() {
      recommendedList = recommendedList;
      calculate();
    });
  }

  calculate() async {
    totalAmount = 0;
    for (var element in recommendedList) {
      setState(() {
        totalAmount +=
            ((element.salePrice.validate()) * (element.qty.validate())).toInt();
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refesh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Giỏ Hàng", style: boldTextStyle(size: 20)),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.separated(
                separatorBuilder: (_, i) => const Divider(),
                shrinkWrap: true,
                reverse: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: recommendedList.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, index) {
                  GSRecommendedModel mData = recommendedList[index];
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
                              Text(mData.title.validate(),
                                  style: boldTextStyle(size: 17), maxLines: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    mData.price.validate().round().toVND(),
                                    style: secondaryTextStyle(
                                        decoration: TextDecoration.lineThrough,
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
                              Row(
                                children: [
                                  commonCacheImageWidget(minusImage, 20,
                                          width: 20)
                                      .onTap(() {
                                    setState(() {
                                      var id = mData.id.validate();
                                      var gtyData = mData.qty.validate();
                                      deleteProductCart(recommendedList, id, 1);
                                      if (gtyData <= 1) return;
                                      var qty = gtyData - 1;
                                      mData.qty = qty;
                                      calculate();
                                    });
                                  }),
                                  16.width,
                                  Row(
                                    children: [
                                      Text(mData.qty.toString(),
                                          style: boldTextStyle()),
                                    ],
                                  ),
                                  16.width,
                                  commonCacheImageWidget(addImage, 20,
                                          width: 20)
                                      .onTap(() {
                                    setState(() {
                                      int id = mData.id.validate();
                                      addProductCart(recommendedList, id,
                                          1); // bất đồng bộ
                                      totalCount = mData.qty! + 1;
                                      mData.qty = totalCount;
                                      calculate();
                                    });
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ).onTap(() {});
                },
              ),
            ).expand(),
            AppButton(
              width: context.width(),
              color: primaryColor,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              onTap: () {
                if (totalAmount == 0) {
                  toast("Giỏ hàng trống");
                  return;
                }
                const GSCheckOutScreen().launch(context);
              },
              child: Row(
                children: [
                  Text("Thanh Toán",
                          style: boldTextStyle(color: Colors.white, size: 18))
                      .expand(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text("Tổng:",
                              style: boldTextStyle(color: Colors.white)),
                          8.width,
                          Text(totalAmount.round().toVND(),
                              style: boldTextStyle(color: Colors.white)),
                        ],
                      ),
                      8.width,
                      Image.asset(nextImage,
                          width: 20, height: 20, color: Colors.white),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

reloadCart(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();

  List<GSRecommendedModel> ListCartUser = await getUserCart(username, password);
  prefs.remove('user_cart');
  prefs.setString('user_cart', jsonEncode(ListCartUser));
}

// reloadCartTemp(List<GSRecommendedModel> listCart, int id, int qty) {
//   for (var element in listCart) {
//     if (element.id == id) {
//       element.qty = element.qty! - qty;
//       return listCart;
//     }
//   }
// }

loadToastError(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

addProductCart(List<GSRecommendedModel> listCart, int id, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  String password = prefs.getString('password') ?? '';

  // String baseUrl = "http://localhost:10561/api";

  var uri = Uri.parse('$baseUrl/add_product_cart');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
    'id': id.toString(),
    'qty': qty.toString(),
  });
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      prefs.remove('user_cart');
      prefs.setString('user_cart', jsonEncode(listCart));
    } else if (data['status'] == 'failed') {
      await Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      loadToastError(data['message']);
    }
  }
}

deleteProductCart(List<GSRecommendedModel> listCart, int id, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  String password = prefs.getString('password') ?? '';
  var uri = Uri.parse('$baseUrl/delete_product_cart');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
    'id': id.toString(),
    'qty': qty.toString(),
  });
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      prefs.remove('user_cart');
      prefs.setString('user_cart', jsonEncode(listCart));
    } else {
      loadToastError(data['message']);
    }
  }
}
