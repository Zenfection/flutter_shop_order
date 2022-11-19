// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:shop_order/model/GSModel.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// // ignore: must_be_immutable
// class GSPromoDetailsScreen extends StatefulWidget {
//   static String tag = '/GSPromoDetailsScreen';
//   GSPromoModel? promoList;

//   GSPromoDetailsScreen({this.promoList});

//   @override
//   GSPromoDetailsScreenState createState() => GSPromoDetailsScreenState();
// }

// class GSPromoDetailsScreenState extends State<GSPromoDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {
//     //
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget('',
//           color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(widget.promoList!.promoImage.validate(),
//                 fit: BoxFit.fill, height: 240, width: context.width()),
//             8.height,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.promoList!.offer.validate(),
//                     style: boldTextStyle(size: 18)),
//                 4.height,
//                 Text("22 Dec 2020", style: secondaryTextStyle()),
//                 16.height,
//                 Text("Use this Voucher in payment page and enjoy your 30% off",
//                     style: primaryTextStyle()),
//                 16.height,
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   color: appStore.isDarkModeOn
//                       ? scaffoldSecondaryDark
//                       : Color(0xFFfff9ed),
//                   child: Row(
//                     children: [
//                       Text("Voucher", style: boldTextStyle()),
//                       16.width,
//                       Container(width: 1, height: 30, color: Colors.grey),
//                       16.width,
//                       Text("HSGBINGVD5", style: secondaryTextStyle()),
//                       Spacer(),
//                       Text("Use", style: boldTextStyle(color: primaryColor))
//                     ],
//                   ),
//                 ),
//                 16.height,
//                 Text("Terms & Conditions", style: boldTextStyle()),
//                 8.height,
//                 UL(
//                   symbolColor: primaryColor,
//                   symbolType: SymbolType.Bullet,
//                   children: [
//                     Text(
//                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
//                       style: primaryTextStyle(size: 14),
//                       textAlign: TextAlign.start,
//                     ),
//                     Text(
//                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
//                       style: primaryTextStyle(size: 14),
//                       textAlign: TextAlign.start,
//                     ),
//                   ],
//                 ),
//               ],
//             ).paddingAll(16),
//           ],
//         ),
//       ),
//     );
//   }
// }
