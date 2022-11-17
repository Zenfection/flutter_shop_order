// import 'package:flutter/material.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/utils/GSImages.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// class GSHelpScreen extends StatefulWidget {
//   static String tag = '/GSHelpScreen';

//   @override
//   GSHelpScreenState createState() => GSHelpScreenState();
// }

// class GSHelpScreenState extends State<GSHelpScreen> {
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
//       appBar: AppBar(
//         backgroundColor: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
//         elevation: 1,
//         titleSpacing: 0,
//         centerTitle: false,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back, color: primaryColor),
//               onPressed: () {
//                 finish(context);
//               },
//             ),
//             8.width,
//             Text("Help", style: boldTextStyle()).expand(),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           helpWidget("Grocery Care", gs_headphone),
//           Divider(),
//           helpWidget("Terms and condition", nextImage),
//           Divider(),
//           helpWidget("Privacy", nextImage),
//         ],
//       ),
//     );
//   }
// }
