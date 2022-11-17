// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:shop_order/utils/FDExpirationFormField.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// class GSAddCardScreen extends StatefulWidget {
//   static String tag = '/GSAddCardScreen';

//   @override
//   GSAddCardScreenState createState() => GSAddCardScreenState();
// }

// class GSAddCardScreenState extends State<GSAddCardScreen> {
//   TextEditingController creditCardController = TextEditingController();
//   TextEditingController cvvController = TextEditingController();
//   TextEditingController expirationController = TextEditingController();

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
//         appBar: gsStatusBarWithTitle(context, "Add Card") as PreferredSizeWidget?,
//         body: Column(
//           children: <Widget>[
//             //TODO credit_card_field Without Nullsafety
//             /* CreditCardFormField(
//               decoration: InputDecoration(
//                 enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
//                 labelStyle: secondaryTextStyle(size: 14),
//                 hintText: "Card Number",
//                 hintStyle: secondaryTextStyle(size: 14),
//                 suffixIcon: Icon(Icons.payment, color: primaryColor),
//               ),
//               controller: creditCardController,
//             ),*/
//             16.height,
//             Row(
//               children: [
//                 ExpirationFormField(
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
//                     hintText: "Exp Date(MM/YY)",
//                     hintStyle: secondaryTextStyle(size: 14),
//                   ),
//                   controller: expirationController,
//                 ).expand(),
//                 8.width,
//                 //TODO credit_card_field Without Nullsafety
//                 /*   CVVFormField(
//                   decoration: InputDecoration(
//                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
//                     hintText: "CVV",
//                     hintStyle: secondaryTextStyle(size: 14),
//                   ),
//                   controller: cvvController,
//                 ).expand(),*/
//               ],
//             ),
//             16.height,
//             CountryCodePicker(
//               onChanged: (e) => print(e.toLongString()),
//               initialSelection: 'FR',
//               dialogBackgroundColor: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
//               showCountryOnly: true,
//               showOnlyCountryWhenClosed: true,
//               showDropDownButton: true,
//               alignLeft: true,
//               favorite: ['+39', 'FR'],
//             ),
//             60.height,
//             gsAppButton(context, 'Save', () {
//               finish(context);
//             }),
//           ],
//         ).paddingAll(16));
//   }
// }
