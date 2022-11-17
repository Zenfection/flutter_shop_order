// import 'package:flutter/material.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:shop_order/main/utils/AppColors.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../../../main.dart';

// class GSForgotPasswordScreen extends StatefulWidget {
//   static String tag = '/GSForgotPasswordScreen';

//   const GSForgotPasswordScreen({super.key});

//   @override
//   GSForgotPasswordScreenState createState() => GSForgotPasswordScreenState();
// }

// class GSForgotPasswordScreenState extends State<GSForgotPasswordScreen> {
//   final formKey = GlobalKey<FormState>();

//   FocusNode emailNode = FocusNode();
//   var emailController = TextEditingController();

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
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Forgot Password", style: boldTextStyle(size: 20)),
//           40.height,
//           Form(
//             child: AppTextField(
//               controller: emailController,
//               textFieldType: TextFieldType.EMAIL,
//               decoration: inputDecoration(label: "Email Address"),
//               focus: emailNode,
//               keyboardType: TextInputType.text,
//             ),
//           ),
//           60.height,
//           gsAppButton(
//             context,
//             'Submit',
//             () {
//               if (formKey.currentState!.validate()) {
//                 finish(context);
//               }
//             },
//           ),
//         ],
//       ).paddingAll(16),
//     );
//   }
// }
