// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shop_order/screens/GSMainScreen.dart';
// import 'package:shop_order/utils/GSColors.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class GSVerificationScreen extends StatefulWidget {
//   static String tag = '/GSVerificationScreen';

//   @override
//   GSVerificationScreenState createState() => GSVerificationScreenState();
// }

// class GSVerificationScreenState extends State<GSVerificationScreen> {
//   StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
//   TextEditingController textEditingController = TextEditingController();
//   String currentText = "";
//   late Timer timer;
//   int counter = 60;

//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) => setState(
//         () {
//           if (counter < 1) {
//             timer.cancel();
//           } else {
//             counter = counter - 1;
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {
//     startTimer();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     errorController.close();
//     super.dispose();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget('', color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             30.height,
//             Text("Verify your number", style: boldTextStyle(size: 20)),
//             30.height,
//             Text(
//               "Enter the 4-digit code we sent you",
//               style: secondaryTextStyle(),
//             ),
//             Text("544545645", style: boldTextStyle(size: 14)),
//             30.height,
//             PinCodeTextField(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               appContext: context,
//               pastedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//               length: 4,
//               obscureText: false,
//               showCursor: false,
//               animationType: AnimationType.fade,
//               errorTextSpace: 30,
//               validator: (v) {
//                 if (v!.length < 3) {
//                   return "Pin is not correct.please try again.";
//                 } else {
//                   return null;
//                 }
//               },
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 fieldHeight: 60,
//                 fieldWidth: 60,
//                 activeFillColor: Colors.transparent,
//                 inactiveFillColor: Colors.transparent,
//                 selectedFillColor: Colors.transparent,
//                 selectedColor: Colors.green,
//                 inactiveColor: Colors.grey[300],
//               ),
//               animationDuration: Duration(milliseconds: 300),
//               textStyle: TextStyle(fontSize: 20, height: 1.6),
//               backgroundColor: Colors.transparent,
//               enableActiveFill: true,
//               errorAnimationController: errorController,
//               controller: textEditingController,
//               keyboardType: TextInputType.number,
//               onCompleted: (v) {},
//               onChanged: (value) {
//                 setState(() {
//                   currentText = value;
//                 });
//               },
//               beforeTextPaste: (text) {
//                 return true;
//               },
//             ),
//             10.height,
//             counter == 0
//                 ? Text("Resend", style: boldTextStyle(color: primaryColor, size: 14)).onTap(() {
//                     startTimer();
//                     counter = 60;
//                     setState(() {});
//                   })
//                 : Text("Resend code in $counter s", style: primaryTextStyle(size: 14)),
//             16.height,
//             Text(
//               "Call me instead",
//               style: boldTextStyle(color: primaryColor, size: 14),
//             ),
//             40.height,
//             gsAppButton(
//               context,
//               'Continue',
//               () {
//                 GSMainScreen().launch(context);
//               },
//             ),
//           ],
//         ).paddingAll(16),
//       ),
//     );
//   }
// }
