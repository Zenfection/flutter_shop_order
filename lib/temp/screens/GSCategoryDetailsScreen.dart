// ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:nb_utils/nb_utils.dart';

// // Source
// import 'package:shop_order/model/GSModel.dart';
// import 'package:shop_order/utils/GSImages.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:shop_order/main/utils/AppWidget.dart';

// // Redicrect
// import 'package:shop_order/screens/GSCheckOutScreen.dart';

// // ignore: must_be_immutable
// class GSCategoryDetailsScreen extends StatefulWidget {
//   static String tag = '/GSCategoryDetailsScreen';
//   GSRecommendedModel? categoryDetails;

//   GSCategoryDetailsScreen({super.key, this.categoryDetails});

//   @override
//   GSCategoryDetailsScreenState createState() => GSCategoryDetailsScreenState();
// }

// class GSCategoryDetailsScreenState extends State<GSCategoryDetailsScreen> {
//   int ratingNum = 0;
//   int counter = 1;

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
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(widget.categoryDetails!.image!,
//                         fit: BoxFit.cover, height: 180, width: 180)
//                     .center(),
//                 16.height,
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(widget.categoryDetails!.title.validate(),
//                             style: boldTextStyle(size: 20)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "\u0024${widget.categoryDetails!.price.validate()}${"/kg"}",
//                               style: secondaryTextStyle(
//                                   decoration: TextDecoration.lineThrough),
//                             ),
//                             8.width,
//                             Text(
//                                 "\u0024${widget.categoryDetails!.price.validate()}${"/kg"}",
//                                 style: primaryTextStyle())
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 8.height,
//                 const Divider(),
//                 8.height,
//                 Text(widget.categoryDetails!.description.validate(),
//                     style: primaryTextStyle(size: 14)),
//                 20.height,
//                 Text("Review", style: boldTextStyle()),
//                 16.height,
//                 Row(
//                   children: [
//                     RatingBar.builder(
//                       initialRating: 5,
//                       minRating: 1,
//                       itemCount: 5,
//                       glow: false,
//                       maxRating: 5,
//                       itemSize: 20,
//                       ignoreGestures: true,
//                       itemBuilder: (context, _) =>
//                           const Icon(Icons.star, color: Colors.amber),
//                       onRatingUpdate: (rating) {
//                         ratingNum = rating.toInt();
//                         setState(() {});
//                       },
//                     ),
//                     8.width,
//                     Text("5.0 from 1.942 users",
//                             style: secondaryTextStyle(size: 12))
//                         .expand(),
//                     Image.asset(
//                       nextImage,
//                       width: 20,
//                       height: 20,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ).onTap(() {}),
//               ],
//             ).paddingAll(16),
//           ).expand(),
//           Container(
//             padding: const EdgeInsets.all(20),
//             alignment: Alignment.bottomCenter,
//             width: context.width(),
//             decoration: boxDecorationWithRoundedCorners(
//               borderRadius: radiusOnly(topRight: 12, topLeft: 12),
//               boxShadow: defaultBoxShadow(),
//               backgroundColor:
//                   appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text("Total", style: boldTextStyle(size: 20)),
//                     8.width,
//                     Text("\u0024${widget.categoryDetails!.salePrice.validate()}",
//                             style: boldTextStyle(size: 20))
//                         .expand(),
//                     Row(
//                       children: [
//                         counter != 1
//                             ? commonCacheImageWidget(minusImage, 20, width: 20)
//                                 .onTap(() {
//                                 setState(() {
//                                   counter--;
//                                 });
//                               })
//                             : Container(),
//                         16.width,
//                         Text('$counter', style: boldTextStyle()),
//                         16.width,
//                         commonCacheImageWidget(addImage, 24, width: 24)
//                             .onTap(() {
//                           setState(() {
//                             counter++;
//                           });
//                         }),
//                       ],
//                     ),
//                   ],
//                 ),
//                 20.height,
//                 Text(
//                   widget.categoryDetails!.description.validate(),
//                   style: secondaryTextStyle(),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//                 30.height,
//                 gsAppButton(context, "Checkout", () {
//                   GSCheckOutScreen().launch(context);
//                 })
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
