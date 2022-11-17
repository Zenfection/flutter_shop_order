// import 'package:flutter/material.dart';
// import 'package:shop_order/temp/screens/GSAddCardScreen.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/utils/GSImages.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:shop_order/main/utils/AppWidget.dart';
// import 'package:nb_utils/nb_utils.dart';

// class GSPaymentScreen extends StatefulWidget {
//   static String tag = '/GSPaymentScreen';

//   @override
//   GSPaymentScreenState createState() => GSPaymentScreenState();
// }

// class GSPaymentScreenState extends State<GSPaymentScreen> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {
//     //
//   }

//   Widget rowWidget(String image, String title) {
//     return Row(
//       children: [
//         Image.asset(image, height: 40, width: 40, fit: BoxFit.cover),
//         16.width,
//         Text(title, style: boldTextStyle()).expand(),
//         Icon(Icons.navigate_next_outlined, color: primaryColor),
//       ],
//     );
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: gsStatusBarWithTitle(context, "Payment") as PreferredSizeWidget?,
//         body: SingleChildScrollView(
//           physics: ClampingScrollPhysics(),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Payment Method", style: secondaryTextStyle(size: 16)).paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(16),
//                     color: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
//                     child: Column(
//                       children: [
//                         rowWidget(gs_visa_icon, "Credit or Debit Card").onTap(() {
//                           GSAddCardScreen().launch(context);
//                         }),
//                         16.height,
//                         rowWidget(gs_paypal_icon, "Paypal").onTap(() {}),
//                         16.height,
//                         rowWidget(gs_cash_icon, "Cash").onTap(() {}),
//                       ],
//                     ),
//                   ),
//                   Text("Voucher", style: secondaryTextStyle(size: 16)).paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(16),
//                     color: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             commonCacheImageWidget(nagivateNextImage, 24, width: 24, fit: BoxFit.cover),
//                             16.width,
//                             Text("My Voucher", style: boldTextStyle()).expand(),
//                             Icon(Icons.navigate_next_outlined, color: primaryColor),
//                           ],
//                         ).onTap(() {}),
//                         32.height,
//                         Row(
//                           children: [
//                             commonCacheImageWidget(nagivateNextImage, 24, width: 24, fit: BoxFit.cover),
//                             16.width,
//                             Text("Gift Card", style: boldTextStyle()).expand(),
//                             Icon(Icons.navigate_next_outlined, color: primaryColor),
//                           ],
//                         ).onTap(() {}),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
