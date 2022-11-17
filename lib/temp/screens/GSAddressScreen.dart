// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:shop_order/model/GSModel.dart';
// import 'package:shop_order/screens/GSAddAddressScreen.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/utils/GSDataProvider.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// class GSAddressScreen extends StatefulWidget {
//   static String tag = '/GSAddressScreen';

//   const GSAddressScreen({super.key});

//   @override
//   GSAddressScreenState createState() => GSAddressScreenState();
// }

// class GSAddressScreenState extends State<GSAddressScreen> {
//   int? tappedIndex;
//   List<GSAddressModel> addressList = getAddressList();

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {
//     tappedIndex = 0;
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: gs_background,
//       appBar: AppBar(
//         backgroundColor:
//             appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
//         elevation: 1,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 finish(context);
//               },
//             ),
//             8.width,
//             Text("My Address", style: boldTextStyle()).expand(),
//             Text("Add", style: primaryTextStyle(color: primaryColor)).onTap(() {
//               GSAddAddressScreen().launch(context);
//             })
//           ],
//         ).paddingRight(12),
//       ),
//       body: ListView.builder(
//           shrinkWrap: true,
//           padding: const EdgeInsets.only(top: 8, bottom: 8),
//           itemCount: addressList.length,
//           itemBuilder: (context, index) {
//             GSAddressModel mData = addressList[index];
//             return Slidable(
//               key: const ValueKey(1),
//               startActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 dismissible: DismissiblePane(onDismissed: () {}),
//                 children: const [
//                   SlidableAction(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     icon: Icons.edit,
//                     label: 'Edit',
//                     onPressed: doNothing,
//                   ),
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFFFE4A49),
//                     foregroundColor: Colors.white,
//                     icon: Icons.delete_outline,
//                   ),
//                 ],
//               ),
//               child: Container(
//                 decoration: boxDecorationWithRoundedCorners(
//                   borderRadius: radius(8),
//                   border: tappedIndex == index
//                       ? Border.all(color: primaryColor)
//                       : Border.all(color: Colors.white),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(mData.address!, style: boldTextStyle()),
//                     4.width,
//                     Text(mData.city!, style: secondaryTextStyle(size: 14)),
//                     Text(mData.state!, style: secondaryTextStyle(size: 14)),
//                     4.height,
//                     Text(mData.pinCode!, style: primaryTextStyle(size: 14)),
//                   ],
//                 ),
//               ).paddingOnly(left: 16, right: 16, top: 8, bottom: 8).onTap(() {
//                 setState(() {
//                   tappedIndex = index;
//                 });
//               }),
//             );
//           }),
//     );
//   }
// }

// void doNothing(BuildContext context) {}
