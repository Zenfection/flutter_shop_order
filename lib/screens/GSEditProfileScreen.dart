// ignore_for_file: file_names

import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/AppConstants.dart';

// Redirect
import 'package:shop_order/screens/GSAccountScreen.dart';

class GSEditProfileScreen extends StatefulWidget {
  static String tag = '/GSEditProfileScreen';

  const GSEditProfileScreen({super.key});

  @override
  GSEditProfileScreenState createState() => GSEditProfileScreenState();
}

class GSEditProfileScreenState extends State<GSEditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController dateOfBirthController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode addressNode = FocusNode();
  // FocusNode dateOfBirthNode = FocusNode();

  // DateTime? _date;
  String value = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    String password = prefs.getString('password')!;
    var data = await getUserInfo(username, password);
    setState(() {
      nameController.text = data[0].fullname;
      emailController.text = data[0].email;
      phoneController.text = data[0].phone;
      addressController.text = data[0].address;
    });
  }

  // Future<void> selectDate(BuildContext context) async {
  //   DateTime? _datePicker = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1947),
  //     lastDate: DateTime(2030),
  //   );
  //   if (_datePicker != null && _datePicker != _date) {
  //     _date = _datePicker;
  //   }
  // }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: gsStatusBarWithTitle(context, "Thông Tin Cá Nhân")
          as PreferredSizeWidget?,
      body: Stack(
        children: [
          ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      avatarLogo,
                      width: 110,
                      height: 110,
                      fit: BoxFit.fill,
                    ).cornerRadiusWithClipRRect(60).center(),
                    16.height,
                    AppTextField(
                      autoFocus: false,
                      controller: nameController,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(label: "Họ Và Tên"),
                      focus: nameNode,
                      nextFocus: emailNode,
                      keyboardType: TextInputType.text,
                    ),
                    16.height,
                    AppTextField(
                      autoFocus: false,
                      controller: emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(label: "Địa Chỉ Email"),
                      focus: emailNode,
                      keyboardType: TextInputType.text,
                    ),
                    16.height,
                    AppTextField(
                      autoFocus: false,
                      controller: addressController,
                      textFieldType: TextFieldType.ADDRESS,
                      decoration: inputDecoration(label: "Địa Chỉ Nhận Hàng"),
                      focus: addressNode,
                      keyboardType: TextInputType.text,
                    ),
                    16.height,
                    // TextFormField(
                    //   textAlign: TextAlign.start,
                    //   controller: dateOfBirthController,
                    //   autofocus: false,
                    //   showCursor: false,
                    //   keyboardType: TextInputType.number,
                    //   decoration: inputDecoration(label: "Date of Birth"),
                    //   onTap: () async {
                    //     hideKeyboard(context);
                    //     await selectDate(context);
                    //     dateOfBirthController.text = _date!.day.toString();
                    //     dateOfBirthController.text = _date!.month.toString();
                    //     dateOfBirthController.text = _date!.year.toString();
                    //     value = dateOfBirthController.text =
                    //         // ignore: prefer_interpolation_to_compose_strings
                    //         _date!.day.toString() +
                    //             "/" +
                    //             _date!.month.toString() +
                    //             "/" +
                    //             _date!.year.toString();
                    //     setState(() {});
                    //   },
                    // ),
                    20.height,
                    Row(
                      children: [
                        CountryCodePicker(
                          onChanged: print,
                          enabled: false,
                          initialSelection: 'VN',
                          favorite: const ['+84', 'VN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        AppTextField(
                          autoFocus: false,
                          controller: phoneController,
                          textFieldType: TextFieldType.PHONE,
                          focus: phoneNode,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: grey)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: "Số điện thoại của bạn",
                            hintStyle: secondaryTextStyle(size: 14),
                          ),
                        ).expand()
                      ],
                    ),
                  ],
                ).paddingAll(16),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: gsAppButton(
              context,
              'Save',
              () {
                changeInfo(context, nameController.text, emailController.text,
                    addressController.text, phoneController.text);
              },
            ),
          ),
        ],
      ).withHeight(context.height()),
    ).paddingOnly(top: 16);
  }
}

changeInfo(var context, String fullname, String email, String address,
    String phone) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = prefs.getString('username')!;
  var uri = Uri.parse(
      '$baseUrl/change_user_info/$user/$fullname/$email/$address/$phone');
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['status'] == 'success') {
      const GSAccountScreen().launch(context);
    } else {
      return false;
    }
  }
}
