// import 'package:flutter/material.dart';
// import 'package:shop_order/utils/GSWidgets.dart';
// import 'package:nb_utils/nb_utils.dart';

// class GSAddAddressScreen extends StatefulWidget {
//   static String tag = '/GSAddAddressScreen';

//   const GSAddAddressScreen({super.key});

//   @override
//   GSAddAddressScreenState createState() => GSAddAddressScreenState();
// }

// class GSAddAddressScreenState extends State<GSAddAddressScreen> {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController pinCodeController = TextEditingController();
//   FocusNode addressNode = FocusNode();
//   FocusNode cityNode = FocusNode();
//   FocusNode countryNode = FocusNode();
//   FocusNode pinCodeNode = FocusNode();

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
//       appBar:
//           gsStatusBarWithTitle(context, "Add Address") as PreferredSizeWidget?,
//       body: Stack(
//         children: [
//           ListView(
//             shrinkWrap: true,
//             children: [
//               Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     AppTextField(
//                       autoFocus: false,
//                       controller: addressController,
//                       textFieldType: TextFieldType.OTHER,
//                       decoration: inputDecoration(label: "Address"),
//                       focus: addressNode,
//                       nextFocus: cityNode,
//                       keyboardType: TextInputType.text,
//                     ),
//                     16.height,
//                     AppTextField(
//                       autoFocus: false,
//                       controller: cityController,
//                       textFieldType: TextFieldType.OTHER,
//                       decoration: inputDecoration(label: "City"),
//                       focus: cityNode,
//                       nextFocus: countryNode,
//                       keyboardType: TextInputType.text,
//                     ),
//                     16.height,
//                     AppTextField(
//                       autoFocus: false,
//                       controller: countryController,
//                       textFieldType: TextFieldType.OTHER,
//                       decoration: inputDecoration(label: "Country"),
//                       focus: countryNode,
//                       nextFocus: pinCodeNode,
//                       keyboardType: TextInputType.text,
//                     ),
//                     16.height,
//                     AppTextField(
//                       autoFocus: false,
//                       controller: pinCodeController,
//                       textFieldType: TextFieldType.OTHER,
//                       decoration: inputDecoration(label: "PinCode"),
//                       focus: pinCodeNode,
//                       keyboardType: TextInputType.number,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ).paddingAll(16),
//           Positioned(
//             bottom: 16,
//             right: 16,
//             left: 16,
//             child: gsAppButton(
//               context,
//               'Add Address',
//               () {
//                 if (formKey.currentState!.validate()) {
//                   finish(context);
//                 }
//               },
//             ),
//           ),
//         ],
//       ).withHeight(context.height()),
//     );
//   }
// }
